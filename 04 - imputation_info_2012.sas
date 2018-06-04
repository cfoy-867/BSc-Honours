/********************************************/
/* Size information to determine imputation */
/********************************************/
/************* Statistics for ALL Food groups for unique products ************************/
/* POST-SIZE EXTRACTION USING FINAL RAW DATA*/
TITLE1 "BSc (Honours) - Chrystal Foy";
LIBNAME cfoy "F:";

/* final_2012 */
/* rename as temporary copy of file in WORK folder*/
DATA final_2012;
SET cfoy.final_2012;
RUN;

/* unique items by FG levels 1, 2 and 3 for ALL possible items*/
PROC SQL;
CREATE TABLE alluniq2012 AS
SELECT DISTINCT Food_Group_Name_1, Food_Group_Code_1, Food_Group_Name_2, Food_Group_Code_2, Food_Group_Name_3, Food_Group_Code_3
FROM final_2012;
QUIT;

/* Ntotals */
/* N_unqi = total # of unique products from final_2012 (regardless with MISSING or NOT missing size) */
/* N_exp = TOTAL expenditure from total unique products in final raw dataset */
PROC SQL;
CREATE TABLE Ntotals AS
SELECT DISTINCT Food_Group_Name_1, Food_Group_Code_1, Food_Group_Name_2, Food_Group_Code_2, Food_Group_Name_3, Food_Group_Code_3,
	COUNT(DISTINCT BARCODE) AS N_unqi,
	SUM(QTY*PRICE) as N_exp
FROM final_2012
GROUP BY Food_Group_Code_1, Food_Group_Code_2, Food_Group_Code_3;
QUIT;

/* n_size = # of unique products from final_2012 (WITH SIZE i.e. SIZE_new is not missing) */
/* n_size_exp = $ of total products within FGs WITH SIZE */
/* n_size_mean = mean size within FGs using only products WITH SIZE */
/* NOTE FG = 010305 has NO observations that have ANY SIZE */
PROC SQL;
CREATE TABLE nsizetotals AS
SELECT DISTINCT Food_Group_Code_1, Food_Group_Code_2, Food_Group_Code_3,
	COUNT(DISTINCT BARCODE) AS n_size,
	SUM(QTY*PRICE) AS n_size_exp
FROM final_2012
WHERE SIZE_new
GROUP BY Food_Group_Code_1, Food_Group_Code_2, Food_Group_Code_3;
QUIT;

/* *****/
PROC SQL;
CREATE TABLE testcombine AS
SELECT L.*, R.*
FROM Ntotals L
LEFT JOIN nsizetotals R
ON L.Food_Group_Code_1 = R.Food_Group_Code_1
AND L.Food_Group_Code_2 = R.Food_Group_Code_2
AND L.Food_Group_Code_3 = R.Food_Group_Code_3;
QUIT;

/* n_size -> mean, median, and modes */
/* subset to get unique products by UNIQUE BARCODE WITH SIZE_new */
PROC SQL;
CREATE TABLE allsubset2012 AS
SELECT DISTINCT(BARCODE), SIZE_new, UNIT_new, Food_Group_Code_1, Food_Group_Code_2, Food_Group_Code_3
FROM final_2012
WHERE SIZE_new
ORDER BY Food_Group_Code_1, Food_Group_Code_2, Food_Group_Code_3;
QUIT;

/* calculate mean median and mode using UNIQUE PRODUCTS = allsubset2012 */
/* CREATE MACRO to add number of observations from master that have sizes that were used to calculate mean, median and mode */
%MACRO select(foodgroup=);
%IF %length(&foodgroup) = 6 %THEN %DO;
PROC MEANS DATA = allsubset2012  MAXDEC = 2 n mean median mode;
TITLE "Statistics for Food Group 3";
VAR SIZE_new;
WHERE Food_Group_Code_3 = "&foodgroup";
OUTPUT out = new(drop = _type_ _freq_) n=n mean=mean median=median mode=mode;
	%END;

	%ELSE %IF %length(&foodgroup) = 4 %THEN %DO;
PROC MEANS DATA = allsubset2012  MAXDEC = 2 n mean median mode;
TITLE "Statistics for Food Group 2";
VAR SIZE_new;
WHERE Food_Group_Code_2 = "&foodgroup";
OUTPUT out = new(drop = _type_ _freq_) n=n mean=mean median=median mode=mode;
	%END;

	%ELSE %DO;
PROC MEANS DATA = allsubset2012  MAXDEC = 2 n mean median mode;
TITLE "Statistics for Food Group 1";
VAR SIZE_new;
WHERE Food_Group_Code_1 = "&foodgroup";
OUTPUT out = new(drop = _type_ _freq_) n=n mean=mean median=median mode=mode;
	%END;

PROC SQL;
CREATE TABLE miss&foodgroup AS
SELECT y.*, "&foodgroup" AS Food_Group_Code
FROM new as y;
QUIT;

%MEND select;

/* execute MACRO for all FG levels*/
%select(foodgroup = 16)
%select(foodgroup = 010104)
%select(foodgroup = 010101)
%select(foodgroup = 010102)
%select(foodgroup = 010103)
%select(foodgroup = 010204)
%select(foodgroup = 010205)
%select(foodgroup = 010206)
%select(foodgroup = 010301)
%select(foodgroup = 010302)
%select(foodgroup = 010305)
%select(foodgroup = 010304)
%select(foodgroup = 0104)
%select(foodgroup = 020101)
%select(foodgroup = 020103)
%select(foodgroup = 020201)
%select(foodgroup = 020202)
%select(foodgroup = 020501)
%select(foodgroup = 020502)
%select(foodgroup = 020504)
%select(foodgroup = 020601)
%select(foodgroup = 020709)
%select(foodgroup = 020705)
%select(foodgroup = 020701)
%select(foodgroup = 020702)
%select(foodgroup = 0302)
%select(foodgroup = 030101)
%select(foodgroup = 030103)
%select(foodgroup = 030104)
%select(foodgroup = 030102)
%select(foodgroup = 0405)
%select(foodgroup = 040101)
%select(foodgroup = 040201)
%select(foodgroup = 040301)
%select(foodgroup = 040302)
%select(foodgroup = 040303)
%select(foodgroup = 040304)
%select(foodgroup = 040401)
%select(foodgroup = 040404)
%select(foodgroup = 040402)
%select(foodgroup = 040403)
%select(foodgroup = 050104)
%select(foodgroup = 050102)
%select(foodgroup = 050103)
%select(foodgroup = 050201)
%select(foodgroup = 050202)
%select(foodgroup = 050203)
%select(foodgroup = 050301)
%select(foodgroup = 050302)
%select(foodgroup = 050403)
%select(foodgroup = 050505)
%select(foodgroup = 050501)
%select(foodgroup = 050506)
%select(foodgroup = 050502)
%select(foodgroup = 050503)
%select(foodgroup = 050602)
%select(foodgroup = 050608)
%select(foodgroup = 050607)
%select(foodgroup = 060201)
%select(foodgroup = 060202)
%select(foodgroup = 060203)
%select(foodgroup = 07)
%select(foodgroup = 080101)
%select(foodgroup = 080105)
%select(foodgroup = 080102)
%select(foodgroup = 080106)
%select(foodgroup = 080103)
%select(foodgroup = 080107)
%select(foodgroup = 090101)
%select(foodgroup = 090102)
%select(foodgroup = 090106)
%select(foodgroup = 090104)
%select(foodgroup = 090201)
%select(foodgroup = 090205)
%select(foodgroup = 090203)
%select(foodgroup = 090204)
%select(foodgroup = 090301)
%select(foodgroup = 090302)
%select(foodgroup = 090401)
%select(foodgroup = 090402)
%select(foodgroup = 090501)
%select(foodgroup = 090502)
%select(foodgroup = 090506)
%select(foodgroup = 090503)
%select(foodgroup = 090504)
%select(foodgroup = 090505)
%select(foodgroup = 100101)
%select(foodgroup = 100201)
%select(foodgroup = 100202)
%select(foodgroup = 100204)
%select(foodgroup = 100218)
%select(foodgroup = 100213)
%select(foodgroup = 100211)
%select(foodgroup = 100217)
%select(foodgroup = 100216)
%select(foodgroup = 100207)
%select(foodgroup = 100208)
%select(foodgroup = 100209)
%select(foodgroup = 1108)
%select(foodgroup = 110105)
%select(foodgroup = 110102)
%select(foodgroup = 110103)
%select(foodgroup = 110104)
%select(foodgroup = 110101)
%select(foodgroup = 110201)
%select(foodgroup = 110301)
%select(foodgroup = 110401)
%select(foodgroup = 110501)
%select(foodgroup = 110502)
%select(foodgroup = 110603)
%select(foodgroup = 110602)
%select(foodgroup = 110704)
%select(foodgroup = 110701)
%select(foodgroup = 110702)
%select(foodgroup = 120101)
%select(foodgroup = 120102)
%select(foodgroup = 120103)
%select(foodgroup = 120201)
%select(foodgroup = 120202)
%select(foodgroup = 120203)
%select(foodgroup = 120204)
%select(foodgroup = 120205)
%select(foodgroup = 120206)
%select(foodgroup = 120207)
%select(foodgroup = 120208)
%select(foodgroup = 120209)
%select(foodgroup = 120210)
%select(foodgroup = 120301)
%select(foodgroup = 120302)
%select(foodgroup = 120303)
%select(foodgroup = 120304)
%select(foodgroup = 130101)
%select(foodgroup = 130103)
%select(foodgroup = 130104)
%select(foodgroup = 130102)
%select(foodgroup = 1401)
%select(foodgroup = 1501)
%select(foodgroup = 1502)
%select(foodgroup = 1503)
%select(foodgroup = 1504)
%select(foodgroup = 1505)
%select(foodgroup = 1506)
%select(foodgroup = 1507)
%select(foodgroup = 17)
RUN;
/* table of statistics of missing items */
DATA missstats_2012;
LENGTH n 8 mean 8 median 8 mode 8 Food_Group_Code $6 ;
SET miss16 miss010104 miss010101 miss010102 miss010103 miss010204 miss010205 miss010206 miss010301 miss010302 miss010305 miss010304 miss0104 miss020101 miss020103 miss020201 miss020202 miss020501 miss020502 miss020504 miss020601 miss020709 miss020705 miss020701 miss020702 miss0302 miss030101 miss030103 miss030104 miss030102 miss0405 miss040101 miss040201 miss040301 miss040302 miss040303
miss040304 miss040401 miss040404 miss040402 miss040403 miss050104 miss050102 miss050103 miss050201 miss050203 miss050202
miss050301 miss050302 miss050403 miss050505 miss050501 miss050506 miss050502 miss050503 miss050602 miss050608 miss050607 
miss060201 miss060202 miss060203 miss07 miss080101 miss080105 miss080102 miss080106 miss080103 miss080107
miss090101 miss090102 miss090106 miss090104 miss090201 miss090205 miss090203 miss090204 miss090301 miss090302 miss090401 miss090402 miss090501 miss090502 miss090506 miss090503 miss090504 miss090505
miss100101 miss100201 miss100202 miss100204 miss100208 miss100218 miss100213 miss100211 miss100217 miss100216 miss100207 miss100207 miss100209 miss1108 miss110105 miss110102 miss110103 miss110104 miss110101 
miss110201 miss110301 miss110401 miss110501 miss110502 miss110603 miss110602 miss110704 miss110701 miss110702 miss120101 miss120102 miss120103 miss120201 miss120202 miss120203 miss120204 miss120205 miss120206 miss120207 miss120208
miss120209 miss120210 miss120301 miss120302 miss120303 miss120304 miss130101 miss130103 miss130104 miss130102 miss1401 miss1501 miss1502 miss1503 miss1504 miss1505 miss1506 miss1507 miss17;
RUN;


/* combine */
PROC SQL;
CREATE TABLE testing2012 AS
SELECT L.*, R.*
FROM testcombine L
LEFT JOIN missstats_2012 R
ON L.Food_Group_Code_1 = R.Food_Group_Code
OR L.Food_Group_Code_2 = R.Food_Group_Code
OR L.Food_Group_Code_3 = R.Food_Group_Code;
QUIT;


/* nmiss = # unique products with MISSING SIZE */
/* table subset but for unique products with MISSING SIZE*/
PROC SQL;
CREATE TABLE nmisstotals AS
SELECT  DISTINCT Food_Group_Name_1, Food_Group_Code_1, Food_Group_Name_2, Food_Group_Code_2, Food_Group_Name_3, Food_Group_Code_3,
	COUNT(DISTINCT BARCODE) AS nmiss,
	SUM(QTY*PRICE) AS nmiss_exp
FROM final_2012
WHERE MISSING(SIZE_new)
GROUP BY Food_Group_Code_1, Food_Group_Code_2, Food_Group_Code_3;
QUIT;

/* join by FG levels */
PROC SQL;
CREATE TABLE combine AS
SELECT L.*, R.*
FROM testing2012 L
LEFT JOIN nmisstotals R
ON L.Food_Group_Code_1 = R.Food_Group_Code_1
AND L.Food_Group_Code_2 = R.Food_Group_Code_2
AND L.Food_Group_Code_3 = R.Food_Group_Code_3;
QUIT;

/* uniqpostmissing_2012 = final table with info for possible imputation */
PROC SQL;
CREATE TABLE uniqpostmissing_2012 AS
SELECT y.*,
	(nmiss/N_unqi*100) AS nmiss_prop format 8.2,
	(nmiss_exp/N_exp*100) AS nmiss_exp_prop format 8.2
FROM combine AS y;
QUIT;
DATA alluniqpostmissing_2012;
	RETAIN Food_Group_Name_1 Food_Group_Code_1 Food_Group_Name_2 Food_Group_Code_2 Food_Group_Name_3 Food_Group_Code_3
			N_unqi N_exp n_size n_size_exp mean median mode nmiss nmiss_prop nmiss_exp nmiss_exp_prop;
	DROP Food_Group_Code N;
SET uniqpostmissing_2012;
RUN;

PROC SORT DATA = alluniqpostmissing_2012;
BY Food_Group_Code_1 Food_Group_Code_3;
RUN;

/* export as xlsx - permanent copy */
DATA cfoy.alluniqpostmissing_2012;
SET alluniqpostmissing_2012;
RUN;

/* export as excel file */
PROC EXPORT DATA = alluniqpostmissing_2012
OUTFILE = 'F:\x Honours Project\02 - Statistical analysis plan (SAP)\003 - Missing sizes\allunqimiss.xlsx' REPLACE
DBMS = xlsx;
SHEET = "all2012miss";
RUN;

/* table of unique products with NMISS and export */
DATA unqimiss_2012;
SET alluniqpostmissing_2012;
WHERE nmiss ne .;
RUN;
PROC EXPORT DATA = unqimiss_2012
OUTFILE = 'F:\x Honours Project\02 - Statistical analysis plan (SAP)\003 - Missing sizes\unqimiss.xlsx' REPLACE
DBMS = xlsx;
SHEET = "2012miss";
RUN;


/** SIZE IMPUTATION RULES **/
/* 1. nmiss_prop <= 25% */
/* 2. nmiss_exp_prop <= 25% */
/* 3. nmiss <= 30 */
/* apply the rules and create subset we will IMPUTE SIZE as excel */
PROC SQL;
CREATE TABLE rulesapplied_2012 AS
SELECT * FROM alluniqpostmissing_2012
WHERE nmiss_prop <= 25
	AND nmiss_exp_prop <= 25
	AND nmiss <= 30
	AND nmiss_prop;
QUIT;

/* export as xlsx - permanent copy */
DATA cfoy.rulesapplied_2012;
SET rulesapplied_2012;
RUN;

/* export as excel file */
PROC EXPORT DATA = rulesapplied_2012
OUTFILE = 'F:\x Honours Project\02 - Statistical analysis plan (SAP)\003 - Missing sizes\rulesuniq.xlsx' REPLACE
DBMS = xlsx;
SHEET = "2012miss";
RUN;

/*************** END ****************************/
