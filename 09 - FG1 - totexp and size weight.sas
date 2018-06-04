/*************************************************************************************/
/* FOOD GROUP 1 - produce weighted estimates of the study outcome */
/*************************************************************************************/
options nofmterr linesize=100 pagesize=55 nonumber nodate formchar = '|_';

%let drive = F:;	*	USB		;
%let todaysdate = %sysfunc(today(), ddmmyyn8.);
TITLE1 "BSc (Honours) - Chrystal Foy";
libname cfoy "&drive";

/* sorting macro */
%MACRO sortit(data, vars);
PROC SORT DATA = &data;
BY &vars;
RUN;
%MEND;

DATA reduced_final;
SET cfoy.reduced_final;
RUN;

/* MACRO for surveymeans to get (MEAN and SEM) by food group 1 by year */
%MACRO surveymeans(data, var, out);
PROC SURVEYMEANS DATA = &data NOBS MEAN STDERR;
DOMAIN YEAR;
VAR &var;
WEIGHT Weight;
ODS OUTPUT DOMAIN = &out;
RUN;
%MEND;

/*** FG1 - total expenditure ***/
%surveymeans(data = reduced_final, var = HH_01_bread_purchases, out = fg1exp);
%surveymeans(data = reduced_final, var = HH_02_cereal_purchases, out = fg2exp);
%surveymeans(data = reduced_final, var = HH_03_confectionary_purchases, out = fg3exp);
%surveymeans(data = reduced_final, var = HH_04_convenience_purchases, out = fg4exp);
%surveymeans(data = reduced_final, var = HH_05_dairy_purchases, out = fg5exp);
%surveymeans(data = reduced_final, var = HH_06_edibleoils_purchases, out = fg6exp);
%surveymeans(data = reduced_final, var = HH__07_eggs_purchases, out = fg7exp);
%surveymeans(data = reduced_final, var = HH_08_fish_purchases, out = fg8exp);
%surveymeans(data = reduced_final, var = HH_09_fruitveges_purchases, out = fg9exp);
%surveymeans(data = reduced_final, var = HH_10_meat_purchases, out = fg10exp);
%surveymeans(data = reduced_final, var = HH_11_nonalcoholic_purchases, out = fg11exp);
%surveymeans(data = reduced_final, var = HH_12_sauces_purchases, out = fg12exp);
%surveymeans(data = reduced_final, var = HH_13_snackfoods_purchases, out = fg13exp);
%surveymeans(data = reduced_final, var = HH_14_specialfoods_purchases, out = fg14exp);
%surveymeans(data = reduced_final, var = HH_15_sugarhoney_purchases, out = fg15exp);
%surveymeans(data = reduced_final, var = HH_16_alcohol_purchases, out = fg16exp);
%surveymeans(data = reduced_final, var = HH_17_unclassified_purchases, out = fg17exp);
QUIT;

DATA fg1totexp;
SET fg1exp fg2exp fg3exp fg4exp fg5exp
fg6exp fg7exp fg8exp fg9exp fg10exp fg11exp
fg12exp fg13exp fg14exp fg15exp fg16exp fg17exp;
RUN;

/* export as csv */
PROC EXPORT DATA = fg1totexp
	OUTFILE = "F:\x Honours Project\02 - Statistical analysis plan (SAP)\007 - IMPUTE - expenditure and weight for each HH per year\household_totals.xlsx" REPLACE
	DBMS = xlsx;
	SHEET = "fg1-totexp";
RUN;

/*** FG1 - total weight (SIZE_new) ***/
%surveymeans(data = reduced_final, var = HH_01_bread_sizenew, out = fg1new);
%surveymeans(data = reduced_final, var = HH_02_cereal_sizenew, out = fg2new);
%surveymeans(data = reduced_final, var = HH_03_confectionary_sizenew, out = fg3new);
%surveymeans(data = reduced_final, var = HH_04_convenience_sizenew, out = fg4new);
%surveymeans(data = reduced_final, var = HH_05_dairy_sizenew, out = fg5new);
%surveymeans(data = reduced_final, var = HH_06_edibleoils_sizenew, out = fg6new);
%surveymeans(data = reduced_final, var = HH_07_eggs_sizenew, out = fg7new);
%surveymeans(data = reduced_final, var = HH_08_fish_sizenew, out = fg8new);
%surveymeans(data = reduced_final, var = HH_09_fruitveges_sizenew, out = fg9new);
%surveymeans(data = reduced_final, var = HH_10_meat_sizenew, out = fg10new);
%surveymeans(data = reduced_final, var = HH_11_nonalcoholic_sizenew, out = fg11new);
%surveymeans(data = reduced_final, var = HH_12_sauces_sizenew, out = fg12new);
%surveymeans(data = reduced_final, var = HH_13_snackfoods_sizenew, out = fg13new);
%surveymeans(data = reduced_final, var = HH_14_specialfoods_sizenew, out = fg14new);
%surveymeans(data = reduced_final, var = HH_15_sugarhoney_sizenew, out = fg15new);
%surveymeans(data = reduced_final, var = HH_16_alcohol_sizenew, out = fg16new);
%surveymeans(data = reduced_final, var = HH_17_unclassified_sizenew, out = fg17new);
QUIT;

DATA fg1totsizenew;
SET fg1new fg2new fg3new fg4new fg5new
fg6new fg7new fg8new fg9new fg10new fg11new
fg12new fg13new fg14new fg15new fg16new fg17new;
RUN;

/* convert to kg */
DATA fg1totsizenew;
SET fg1totsizenew;
Mean = mean/1000;
StdErr = StdErr/1000;
RUN;

/* export as csv */
PROC EXPORT DATA = fg1totsizenew
	OUTFILE = "F:\x Honours Project\02 - Statistical analysis plan (SAP)\007 - IMPUTE - expenditure and weight for each HH per year\household_totals.xlsx" REPLACE
	DBMS = xlsx;
	SHEET = "fg1-totsizenew";
RUN;

/*** FG1 - total weight (size_imputed_mean) ***/
%surveymeans(data = reduced_final, var = HH_01_bread_sizemean, out = fg1mean);
%surveymeans(data = reduced_final, var = HH_02_cereal_sizemean, out = fg2mean);
%surveymeans(data = reduced_final, var = HH_03_confectionary_sizemean, out = fg3mean);
%surveymeans(data = reduced_final, var = HH_04_convenience_sizemean, out = fg4mean);
%surveymeans(data = reduced_final, var = HH_05_dairy_sizemean, out = fg5mean);
%surveymeans(data = reduced_final, var = HH_06_edibleoils_sizemean, out = fg6mean);
%surveymeans(data = reduced_final, var = HH_07_eggs_sizemean, out = fg7mean);
%surveymeans(data = reduced_final, var = HH_08_fish_sizemean, out = fg8mean);
%surveymeans(data = reduced_final, var = HH_09_fruitveges_sizemean, out = fg9mean);
%surveymeans(data = reduced_final, var = HH_10_meat_sizemean, out = fg10mean);
%surveymeans(data = reduced_final, var = HH_11_nonalcoholic_sizemean, out = fg11mean);
%surveymeans(data = reduced_final, var = HH_12_sauces_sizemean, out = fg12mean);
%surveymeans(data = reduced_final, var = HH_13_snackfoods_sizemean, out = fg13mean);
%surveymeans(data = reduced_final, var = HH_14_specialfoods_sizemean, out = fg14mean);
%surveymeans(data = reduced_final, var = HH_15_sugarhoney_sizemean, out = fg15mean);
%surveymeans(data = reduced_final, var = HH_16_alcohol_sizemean, out = fg16mean);
%surveymeans(data = reduced_final, var = HH_17_unclassified_sizemean, out = fg17mean);
QUIT;

DATA fg1totsizemean;
SET fg1mean fg2mean fg3mean fg4mean fg5mean
fg6mean fg7mean fg8mean fg9mean fg10mean fg11mean
fg12mean fg13mean fg14mean fg15mean fg16mean fg17mean;
RUN;

/* convert to kg */
DATA fg1totsizemean;
SET fg1totsizemean;
Mean = mean/1000;
StdErr = StdErr/1000;
RUN;

/* export as csv */
PROC EXPORT DATA = fg1totsizemean
	OUTFILE = "F:\x Honours Project\02 - Statistical analysis plan (SAP)\007 - IMPUTE - expenditure and weight for each HH per year\household_totals.xlsx" REPLACE
	DBMS = xlsx;
	SHEET = "fg1-totsizemean";
RUN;

/*** FG1 - total weight (size_imputed_median) ***/
%surveymeans(data = reduced_final, var = HH_01_bread_sizemedian, out = fg1median);
%surveymeans(data = reduced_final, var = HH_02_cereal_sizemedian, out = fg2median);
%surveymeans(data = reduced_final, var = HH_03_confectionary_sizemedian, out = fg3median);
%surveymeans(data = reduced_final, var = HH_04_convenience_sizemedian, out = fg4median);
%surveymeans(data = reduced_final, var = HH_05_dairy_sizemedian, out = fg5median);
%surveymeans(data = reduced_final, var = HH_06_edibleoils_sizemedian, out = fg6median);
%surveymeans(data = reduced_final, var = HH_07_eggs_sizemedian, out = fg7median);
%surveymeans(data = reduced_final, var = HH_08_fish_sizemedian, out = fg8median);
%surveymeans(data = reduced_final, var = HH_09_fruitveges_sizemedian, out = fg9median);
%surveymeans(data = reduced_final, var = HH_10_meat_sizemedian, out = fg10median);
%surveymeans(data = reduced_final, var = HH_11_nonalcoholic_sizemedian, out = fg11median);
%surveymeans(data = reduced_final, var = HH_12_sauces_sizemedian, out = fg12median);
%surveymeans(data = reduced_final, var = HH_13_snackfoods_sizemedian, out = fg13median);
%surveymeans(data = reduced_final, var = HH_14_specialfoods_sizemedian, out = fg14median);
%surveymeans(data = reduced_final, var = HH_15_sugarhoney_sizemedian, out = fg15median);
%surveymeans(data = reduced_final, var = HH_16_alcohol_sizemedian, out = fg16median);
%surveymeans(data = reduced_final, var = HH_17_unclassified_sizemedian, out = fg17median);
QUIT;

DATA fg1totsizemedian;
SET fg1median fg2median fg3median fg4median fg5median
fg6median fg7median fg8median fg9median fg10median fg11median
fg12median fg13median fg14median fg15median fg16median fg17median;
RUN;

/* convert to kg */
DATA fg1totsizemedian;
SET fg1totsizemedian;
Mean = mean/1000;
StdErr = StdErr/1000;
RUN;

/* export as csv */
PROC EXPORT DATA = fg1totsizemedian
	OUTFILE = "F:\x Honours Project\02 - Statistical analysis plan (SAP)\007 - IMPUTE - expenditure and weight for each HH per year\household_totals.xlsx" REPLACE
	DBMS = xlsx;
	SHEET = "fg1-totsizemedian";
RUN;

/* FG1 - total weight (size_imputed_mode) */
%surveymeans(data = reduced_final, var = HH_01_bread_sizemode, out = fg1mode);
%surveymeans(data = reduced_final, var = HH_02_cereal_sizemode, out = fg2mode);
%surveymeans(data = reduced_final, var = HH_03_confectionary_sizemode, out = fg3mode);
%surveymeans(data = reduced_final, var = HH_04_convenience_sizemode, out = fg4mode);
%surveymeans(data = reduced_final, var = HH_05_dairy_sizemode, out = fg5mode);
%surveymeans(data = reduced_final, var = HH_06_edibleoils_sizemode, out = fg6mode);
%surveymeans(data = reduced_final, var = HH_07_eggs_sizemode, out = fg7mode);
%surveymeans(data = reduced_final, var = HH_08_fish_sizemode, out = fg8mode);
%surveymeans(data = reduced_final, var = HH_09_fruitveges_sizemode, out = fg9mode);
%surveymeans(data = reduced_final, var = HH_10_meat_sizemode, out = fg10mode);
%surveymeans(data = reduced_final, var = HH_11_nonalcoholic_sizemode, out = fg11mode);
%surveymeans(data = reduced_final, var = HH_12_sauces_sizemode, out = fg12mode);
%surveymeans(data = reduced_final, var = HH_13_snackfoods_sizemode, out = fg13mode);
%surveymeans(data = reduced_final, var = HH_14_specialfoods_sizemode, out = fg14mode);
%surveymeans(data = reduced_final, var = HH_15_sugarhoney_sizemode, out = fg15mode);
%surveymeans(data = reduced_final, var = HH_16_alcohol_sizemode, out = fg16mode);
%surveymeans(data = reduced_final, var = HH_17_unclassified_sizemode, out = fg17mode);
QUIT;

DATA fg1totsizemode;
SET fg1mode fg2mode fg3mode fg4mode fg5mode
fg6mode fg7mode fg8mode fg9mode fg10mode fg11mode
fg12mode fg13mode fg14mode fg15mode fg16mode fg17mode;
RUN;

/* convert to kg */
DATA fg1totsizemode;
SET fg1totsizemode;
Mean = mean/1000;
StdErr = StdErr/1000;
RUN;

/* export as csv */
PROC EXPORT DATA = fg1totsizemode
	OUTFILE = "F:\x Honours Project\02 - Statistical analysis plan (SAP)\007 - IMPUTE - expenditure and weight for each HH per year\household_totals.xlsx" REPLACE
	DBMS = xlsx;
	SHEET = "fg1-totsizemode";
RUN;


/***********************************************************/

