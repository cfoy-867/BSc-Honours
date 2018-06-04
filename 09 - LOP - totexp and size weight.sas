/*************************************************************************************/
/* LEVEL OF PROCESSING - produce weighted estimates of the study outcome */
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

/* MACRO for surveymeans to get (MEAN and SEM) by level of processing by year */
%MACRO surveymeans(data, var, out);
PROC SURVEYMEANS DATA = &data NOBS MEAN STDERR;
DOMAIN YEAR;
VAR &var;
WEIGHT Weight;
ODS OUTPUT DOMAIN = &out;
RUN;
%MEND;

/*** LOP - total expenditure ***/
%surveymeans(data = reduced_final, var = HH_Processing_0_purchases, out = pc0exp);
%surveymeans(data = reduced_final, var = HH_Processing_1_purchases, out = pc1exp);
%surveymeans(data = reduced_final, var = HH_Processing_2_purchases, out = pc2exp);
%surveymeans(data = reduced_final, var = HH_Processing_3_purchases, out = pc3exp);
%surveymeans(data = reduced_final, var = HH_Processing_4_purchases, out = pc4exp);
QUIT;

DATA loptotexp;
SET pc0exp pc1exp pc2exp pc3exp pc4exp;
RUN;

/* export as csv */
PROC EXPORT DATA = loptotexp
	OUTFILE = "F:\x Honours Project\02 - Statistical analysis plan (SAP)\007 - IMPUTE - expenditure and weight for each HH per year\household_totals.xlsx" REPLACE
	DBMS = xlsx;
	SHEET = "lop-totexp";
RUN;

/*** LOP - total weight (SIZE_new) ***/
%surveymeans(data = reduced_final, var = HH_Processing_0_sizenew, out = pc0new);
%surveymeans(data = reduced_final, var = HH_Processing_1_sizenew, out = pc1new);
%surveymeans(data = reduced_final, var = HH_Processing_2_sizenew, out = pc2new);
%surveymeans(data = reduced_final, var = HH_Processing_3_sizenew, out = pc3new);
%surveymeans(data = reduced_final, var = HH_Processing_4_sizenew, out = pc4new);
QUIT;

DATA loptotsizenew;
SET pc0new pc1new pc2new pc3new pc4new;
RUN;

/* convert to kg */
DATA loptotsizenew;
SET loptotsizenew;
Mean = mean/1000;
StdErr = StdErr/1000;
RUN;

/* export as csv */
PROC EXPORT DATA = loptotsizenew
	OUTFILE = "F:\x Honours Project\02 - Statistical analysis plan (SAP)\007 - IMPUTE - expenditure and weight for each HH per year\household_totals.xlsx" REPLACE
	DBMS = xlsx;
	SHEET = "lop-totsizenew";
RUN;

/*** LOP - total weight (size_imputed_mean) ***/
%surveymeans(data = reduced_final, var = HH_Processing_0_sizemean, out = pc0mean);
%surveymeans(data = reduced_final, var = HH_Processing_1_sizemean, out = pc1mean);
%surveymeans(data = reduced_final, var = HH_Processing_2_sizemean, out = pc2mean);
%surveymeans(data = reduced_final, var = HH_Processing_3_sizemean, out = pc3mean);
%surveymeans(data = reduced_final, var = HH_Processing_4_sizemean, out = pc4mean);
QUIT;

DATA loptotsizemean;
SET pc0mean pc1mean pc2mean pc3mean pc4mean;
RUN;

/* convert to kg */
DATA loptotsizemean;
SET loptotsizemean;
Mean = mean/1000;
StdErr = StdErr/1000;
RUN;

/* export as csv */
PROC EXPORT DATA = loptotsizemean
	OUTFILE = "F:\x Honours Project\02 - Statistical analysis plan (SAP)\007 - IMPUTE - expenditure and weight for each HH per year\household_totals.xlsx" REPLACE
	DBMS = xlsx;
	SHEET = "lop-totsizemean";
RUN;

/*** LOP - total weight (size_imputed_median) ***/
%surveymeans(data = reduced_final, var = HH_Processing_0_sizemedian, out = pc0median);
%surveymeans(data = reduced_final, var = HH_Processing_1_sizemedian, out = pc1median);
%surveymeans(data = reduced_final, var = HH_Processing_2_sizemedian, out = pc2median);
%surveymeans(data = reduced_final, var = HH_Processing_3_sizemedian, out = pc3median);
%surveymeans(data = reduced_final, var = HH_Processing_4_sizemedian, out = pc4median);
QUIT;

DATA loptotsizemedian;
SET pc0median pc1median pc2median pc3median pc4median;
RUN;

/* convert to kg */
DATA loptotsizemedian;
SET loptotsizemedian;
Mean = mean/1000;
StdErr = StdErr/1000;
RUN;

/* export as csv */
PROC EXPORT DATA = loptotsizemedian
	OUTFILE = "F:\x Honours Project\02 - Statistical analysis plan (SAP)\007 - IMPUTE - expenditure and weight for each HH per year\household_totals.xlsx" REPLACE
	DBMS = xlsx;
	SHEET = "lop-totsizemedian";
RUN;

/* LOP - total weight (size_imputed_mode) */
%surveymeans(data = reduced_final, var = HH_Processing_0_sizemode, out = pc0mode);
%surveymeans(data = reduced_final, var = HH_Processing_1_sizemode, out = pc1mode);
%surveymeans(data = reduced_final, var = HH_Processing_2_sizemode, out = pc2mode);
%surveymeans(data = reduced_final, var = HH_Processing_3_sizemode, out = pc3mode);
%surveymeans(data = reduced_final, var = HH_Processing_4_sizemode, out = pc4mode);
QUIT;

DATA loptotsizemode;
SET pc0mode pc1mode pc2mode pc3mode pc4mode;
RUN;

/* convert to kg */
DATA loptotsizemode;
SET loptotsizemode;
Mean = mean/1000;
StdErr = StdErr/1000;
RUN;

/* export as csv */
PROC EXPORT DATA = loptotsizemode
	OUTFILE = "F:\x Honours Project\02 - Statistical analysis plan (SAP)\007 - IMPUTE - expenditure and weight for each HH per year\household_totals.xlsx" REPLACE
	DBMS = xlsx;
	SHEET = "lop-totsizemode";
RUN;

/************************************ END *********************************************/
