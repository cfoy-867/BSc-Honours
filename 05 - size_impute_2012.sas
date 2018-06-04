/********************************************/
/* New size variables = size_impute_(mean, median, mode) */
/********************************************/
/* POST-SIZE EXTRACTION USING FINAL RAW DATA*/
TITLE1 "BSc (Honours) - Chrystal Foy";
LIBNAME cfoy "F:";

/* final_2012 and calculated statistics table (mean, median, mode) */
/* rename as temporary copy of file in WORK folder*/
DATA final_2012;
SET cfoy.final_2012;
RUN;

/** SIZE IMPUTATION RULES **/
/* 1. nmiss_prop <= 25% */
/* 2. nmiss_exp_prop <= 25% */
/* 3. nmiss <= 30 */
/* import table with food groups (at the lowest level) that SATISFY OUR IMPUTATION RULES and keep certain vars */
DATA rulesapplied_2012;
SET cfoy.rulesapplied_2012;
KEEP Food_Group_Code_1 Food_Group_Code_2 Food_Group_Code_3 mean median mode;
RUN;

/* sort full dataset by Food groups */
PROC SORT DATA = final_2012;
BY Food_Group_Code_1 Food_Group_Code_2 Food_Group_Code_3;
RUN;

/* merge final dataset with rulesapplied to add mean, median, mode for imputation */
DATA merged;
	MERGE final_2012 rulesapplied_2012;
	BY Food_Group_Code_1 Food_Group_Code_2 Food_Group_Code_3;
RUN;

/* create dataset and impute size for mean median and mode variables for missing SIZE_new, else set as SIZE_new */
/* new variables size_impute_mean (median and mode) */
DATA imputed_final_2012;
SET merged;
IF MISSING(SIZE_new) THEN
	DO;
	size_imputed_mean = mean;
	size_imputed_median = median;
	size_imputed_mode = mode;
	END;
ELSE
	DO;
	size_imputed_mean = SIZE_new;
	size_imputed_median = SIZE_new;
	size_imputed_mode = SIZE_new;
	END;
RUN;

/* remove variables mean median and mode */
DATA imputed_final_2012;
SET imputed_final_2012;
DROP mean median mode;
RUN;

/* rearrange variables so SIZES are next to each other */
DATA imputed_final_2012;
RETAIN HH Weight Lifestage Income_Group HH_Size Age_Group Sex Adults Children PostCode Date Barcode SHOP_DESC
	BARCODE_DESC DEPARTMENT PC SIZE SIZE_new UNIT size_imputed_mean size_imputed_median size_imputed_mode UNIT_new;
SET imputed_final_2012;
RUN;

/* create permanent dataset */
DATA cfoy.imputed_final_2012;
SET imputed_final_2012;
RUN;
/***************************** END *****************************/

/* checking number of observations still with missing size after imputation */
/* GOOD: checks checkout = 69,168 obs still missing SIZE - same as first attempt */
PROC SQL;
CREATE TABLE checks AS
SELECT * FROM imputed_final_2012
WHERE MISSING(size_imputed_mean);
QUIT;
/*****************************************************************/
