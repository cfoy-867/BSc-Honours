DATA imputed_final_2012;
SET cfoy.imputed_final_2012;
RUN;

/* original package size (no size imputation) */
PROC UNIVARIATE DATA=imputed_final_2012;
VAR SIZE_new;
HISTOGRAM SIZE_new / ODSTITLE = "Distribution of package size (no size imputation)";
OUTPUT;
RUN;

/* size with imputed mean size */
PROC UNIVARIATE DATA=imputed_final_2012;
VAR size_imputed_mean;
HISTOGRAM size_imputed_mean / ODSTITLE = "Distribution of package size (imputed mean size)";
OUTPUT;
RUN;

/* size with imputed median size */
PROC UNIVARIATE DATA=imputed_final_2012;
VAR size_imputed_median;
HISTOGRAM size_imputed_median / ODSTITLE = "Distribution of package size (imputed median size)";
OUTPUT;
RUN;

/* size with imputed mode size */
PROC UNIVARIATE DATA=imputed_final_2012;
VAR size_imputed_mode;
HISTOGRAM size_imputed_mode / ODSTITLE = "Distribution of package size (imputed mode size)";
OUTPUT;
RUN;
