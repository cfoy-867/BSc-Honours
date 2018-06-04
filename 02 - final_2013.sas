/*****************************************************/
/******* DEALING WITH ITEM SIZES AND UNITS ***********/
/*(using homescan_year_final.sas7bdat files)(Hard-drive)*/
/*****************************************************/

/* setting up */
TITLE1 "BSc (Honours) - Chrystal Foy";
LIBNAME cfoy "F:";

/* homescan 2013 */
/* rename as temporary copy of file in WORK folder*/
DATA homescan_2013;
SET cfoy.homescan_2013_final;
RUN;

/* 2013 total household expenditure sum(QTY * PRICE) */
PROC SQL;
TITLE 'Homescan dataset (2013): Total household expenditure';
SELECT SUM(QTY*PRICE) as ExpenditureTotal
FROM homescan_2013;
QUIT;


/******************************************/
/****** CONSISTENCY: Sizes and units  *****/
/******************************************/
/*  (15 levels) different levels for size unit */
PROC FREQ DATA = homescan_2013 nlevels;
TABLES UNIT;
TITLE 'Homescan dataset (2013): UNIT from Nielsen panel';
RUN;
/*  (2 levels g or ml + missing level) different levels for size unit */
PROC FREQ DATA = homescan_2013 nlevels;
TABLES Packet_Unit;
TITLE 'Homescan dataset (2013): Packet Unit from Supermarket database';
RUN;

/* checking levels of "LINK" with supermarket data */
PROC FREQ DATA = homescan_2013 nlevels;
TABLES link;
RUN;

/*  CREATE new variable: Item_size in a temp copy of the file */
/* IF "link"ed to supermarket data and Packet_unit in (m or g) use Packet_size*/
DATA varsaddedhomescan_2013;
SET homescan_2013;
IF link ne "No" AND Packet_Unit in ('mL', 'g') AND Packet_Size ne 0 then
	DO;
		Item_size = Packet_Size;
		Item_unit = Packet_Unit;
	END;
ELSE IF link = "No" AND UNIT in ('ML', 'G') then
	DO;
		Item_size = SIZE;
		Item_unit = UNIT;
	END;
RUN;

PROC FREQ DATA = varsaddedhomescan_2013;
TABLE Item_size / norow nocol nopercent;
RUN;

DATA cfoy.varsaddedhomescan_2013;
SET varsaddedhomescan_2013;
RUN;

DATA varsaddedhomescan_2013;
SET cfoy.varsaddedhomescan_2013;
RUN;

/* checking Item_unit and Item_size (110,487 obs were missing a unit and weight) */
	/* 110,487/1,911,257 = approx 5.78% obs missing in item size and unit */
PROC MEANS DATA = varsaddedhomescan_2013 NMISS N;
VAR Item_size;
RUN;
PROC FREQ DATA = varsaddedhomescan_2013 nlevels;
TABLES Item_unit;
TITLE 'Homescan dataset (2013): Item Units';
RUN;


/**********************************/
/***** ITEMS WITH MISSING SIZE ****/
/**********************************/
/* can we still get the item size some other way? */
/* export as EXCEL and use R programming and regular expressions to extract sizes from barcode description (SEE "extracing sizes.Rmd") */
/* these observations either have missing Packet_Size and/or Packet_Unit if linked */
/* if not linked, then they are missing SIZE or UNIT is not in g or ml */
DATA missing_size_2013;
SET varsaddedhomescan_2013 (KEEP = HH WEIGHT Barcode BARCODE_DESC SIZE UNIT link Packet_Size Packet_Unit
Food_Group_Name_1 Food_Group_Code_1 
Food_Group_Name_2 Food_Group_Code_2 
Food_Group_Name_3 Food_Group_Code_3
LEVEL_OF_PROCESSING PROCESSING_CODE 
Serving_Size Serving_Unit Item_size Item_unit);
WHERE Item_size IS MISSING OR Item_unit IS MISSING;
RUN;
PROC SORT DATA=missing_size_2013 OUT=cfoy.missing_size_2013 (DROP = Packet_Size Packet_Unit Item_size Item_unit);
BY UNIT;
RUN;
/* export as excel file */
PROC EXPORT DATA = cfoy.missing_size_2013
OUTFILE = 'E:\x Honours Project\02 - Statistical analysis plan (SAP)\003 - Missing sizes\missingsizes.xlsx'
DBMS = xlsx REPLACE;
SHEET = "2013missing";
RUN;







/****************************************************************************/
/* combine "extract2013.csv" into master dataset "varsaddedhomescan_2012" */
/****************************************************************************/
/* import "extract2013.csv" file into SAS */
/* PROC IMPORT for csv files TRUNCATES variables based on default guessingrows=20 -> changed to total # of obs in csv to avoid truncation */
PROC IMPORT DATAFILE = "F:\x Honours Project\02 - Statistical analysis plan (SAP)\003 - Missing sizes\extract2013.csv" OUT = extracted_2013
DBMS = csv REPLACE;
GETNAMES = YES;
GUESSINGROWS = 110487;
RUN;

/* select only certain variables and set NA = .  and SIZE_new as numeric*/
DATA extracted_2013;
SET extracted_2013 (KEEP = HH Weight BARCODE BARCODE_DESC SIZE_new UNIT_new);
IF SIZE_new = "NA" & UNIT_new = "NA" THEN
	DO;
		SIZE_new = .;
		UNIT_new = .;
	END;
RUN;

/* modify the master dataset "varsaddedhomescan_2013" with transaction dataset "extracted_2013" */
/* FIRST: create "uniquebar2013" table that contains all the possible unique barcodes, barcodes_desc, size and unit */
PROC SQL;
CREATE TABLE uniquebar2013 AS
SELECT DISTINCT Barcode, Barcode_desc, SIZE_new, UNIT_new
FROM extracted_2013;

/* SECOND: new dataset with master and transaction dataset by one-to-many matching using LEFT JOIN called "onemerge_test" */
CREATE TABLE onemerge_2013 AS
SELECT A.*, B.SIZE_new, B.UNIT_new
FROM varsaddedhomescan_2013 A LEFT JOIN uniquebar2013 B
ON A.Barcode = B.Barcode
ORDER BY HH;
QUIT;

/* for SIZE_new and UNIT_new that are still missing replace with . to used for next step */
DATA final_2013;
SET onemerge_2013;
IF SIZE_new = " " THEN
	DO;
	SIZE_new = .;
	END;
IF  UNIT_new = " "  THEN
	DO;
	UNIT_new = .;
	END;
RUN;

/* if Item_size and unit are MISSING, use NEW size and unit */
DATA final_2013;
SET final_2013;
IF SIZE_new = . AND UNIT_new = . THEN
	DO;
	SIZE_new = Item_size;
	UNIT_new = Item_unit;
	END;
RUN;

/* remove vars Item_size and Item_unit as SIZE_new and UNIT_new will be our final sizes extracted from original data */
/* make sure SIZE is numeric */
DATA final_2013;
SET final_2013 (DROP = Item_size Item_unit);
new = input(SIZE_new, 12.);
DROP SIZE_new;
RENAME new = SIZE_new;
new2 = PUT(UNIT_new, $4.);
DROP UNIT_new;
RENAME new2 = UNIT_new;
RUN;

/* (YES!) CHECK items have been read properly and the total items still missig size is 82,689 */
PROC FREQ DATA=final_2013;
TABLES SIZE_new /missing;
RUN;

/* make UNIT_new units consistent i.e. all in capital "G" and "ML" */
DATA final_2013;
SET final_2013;
IF UNIT_new = "g" THEN
	DO;
	UNIT_new = "G";
	END;
IF  UNIT_new in ("ml", "mL", "Ml")  THEN
	DO;
	UNIT_new = "ML";
	END;
RUN;

/* rearrange variable columns to compare SIZE and UNIT with the SIZE_new and UNIT_new */
DATA final_2013;
      RETAIN HH Weight Lifestage Income_Group HH_Size Age_Group Sex Adults
               Children PostCode Date Barcode SHOP_DESC BARCODE_DESC DEPARTMENT PC
               SIZE SIZE_new UNIT UNIT_new;
	SET final_2013;
RUN;

/* fixing errors in food group codings */
DATA final_2013;
SET final_2013;
IF Food_Group_Code_2 = "0905" AND Food_Group_Code_3 = "090104" THEN 
	Food_Group_Code_2 = "0901";
IF Food_Group_Code_1 = "12" AND Food_Group_Code_3 = "090505" THEN
	DO; Food_Group_Code_1 = "09";
		Food_Group_Code_2 = "0905";
	END;
IF Food_Group_Code_2 = "1203" AND Food_Group_Code_3 = "120210" THEN
	Food_Group_Code_2 = "1202";
RUN;

/* EXPORT FINAL RAW DATASET FOR 2013 as permanent SAS table file */
DATA cfoy.final_2013;
SET final_2013;
RUN;

/* read raw dataset back into SAS from permanent file */
DATA final_2013;
SET cfoy.final_2013;
RUN;

/* END */
/******************************************************************************/
