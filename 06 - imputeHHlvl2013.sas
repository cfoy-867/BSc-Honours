/******************************************************/
/* TOTAL EXPENDITURE AND WEIGHT PURCHASED FOR EACH HH */
/******************************************************/

TITLE1 "BSc (Honours) - Chrystal Foy";
LIBNAME cfoy "E:";

/* using IMPUTED_FINAL_2013 datasets with SIZE_NEW, SIZE_IMPUTED_MEAN, SIZE_IMPUTED_MEDIAN, SIZE_IMPUTED_MODE */
/* load back into SAS our permanent copy */
DATA imputed_final_2013;
SET cfoy.imputed_final_2013;
RUN;

/* level of processing */
/* LOP - expenditure, and weights (size new, mean, median and mode) */
DATA imputed_final_2013;
SET imputed_final_2013;
IF PROCESSING_CODE = 0 THEN
	DO;
		Processing_0_sizenew = SUM(QTY*SIZE_new);
		Processing_0_sizemean = SUM(QTY*size_imputed_mean);
		Processing_0_sizemedian = SUM(QTY*size_imputed_median);
		Processing_0_sizemode = SUM(QTY*size_imputed_mode);
		Processing_0_purchases = SUM(QTY*PRICE);
	END;
ELSE IF PROCESSING_CODE = 1 THEN
	DO;
		Processing_1_sizenew = SUM(QTY*SIZE_new);
		Processing_1_sizemean = SUM(QTY*size_imputed_mean);
		Processing_1_sizemedian = SUM(QTY*size_imputed_median);
		Processing_1_sizemode = SUM(QTY*size_imputed_mode);
		Processing_1_purchases = SUM(QTY*PRICE);
	END;
ELSE IF PROCESSING_CODE = 2 THEN
	DO;
		Processing_2_sizenew = SUM(QTY*SIZE_new);
		Processing_2_sizemean = SUM(QTY*size_imputed_mean);
		Processing_2_sizemedian = SUM(QTY*size_imputed_median);
		Processing_2_sizemode = SUM(QTY*size_imputed_mode);
		Processing_2_purchases = SUM(QTY*PRICE);
	END;
ELSE IF PROCESSING_CODE = 3 THEN
	DO;
		Processing_3_sizenew = SUM(QTY*SIZE_new);
		Processing_3_sizemean = SUM(QTY*size_imputed_mean);
		Processing_3_sizemedian = SUM(QTY*size_imputed_median);
		Processing_3_sizemode = SUM(QTY*size_imputed_mode);
		Processing_3_purchases = SUM(QTY*PRICE);
	END;
ELSE
	DO;
		Processing_4_sizenew = SUM(QTY*SIZE_new);
		Processing_4_sizemean = SUM(QTY*size_imputed_mean);
		Processing_4_sizemedian = SUM(QTY*size_imputed_median);
		Processing_4_sizemode = SUM(QTY*size_imputed_mode);
		Processing_4_purchases = SUM(QTY*PRICE);
	END;
RUN;

/* food group level 1 */
DATA imputed_final_2013;
SET imputed_final_2013;
IF Food_Group_Code_1 = "01" THEN
	DO;
		_01_bread_sizenew = SUM(QTY*SIZE_new);
		_01_bread_sizemean = SUM(QTY*size_imputed_mean);
		_01_bread_sizemedian = SUM(QTY*size_imputed_median);
		_01_bread_sizemode = SUM(QTY*size_imputed_mode);
		_01_bread_purchases = SUM(QTY*PRICE);
	END;
ELSE IF Food_Group_Code_1 = "02" THEN
	DO;
		_02_cereal_sizenew = SUM(QTY*SIZE_new);
		_02_cereal_sizemean = SUM(QTY*size_imputed_mean);
		_02_cereal_sizemedian = SUM(QTY*size_imputed_median);
		_02_cereal_sizemode = SUM(QTY*size_imputed_mode);
		_02_cereal_purchases = SUM(QTY*PRICE);
	END;
ELSE IF Food_Group_Code_1 = "03" THEN
	DO;
		_03_confectionary_sizenew = SUM(QTY*SIZE_new);
		_03_confectionary_sizemean = SUM(QTY*size_imputed_mean);
		_03_confectionary_sizemedian = SUM(QTY*size_imputed_median);
		_03_confectionary_sizemode = SUM(QTY*size_imputed_mode);
		_03_confectionary_purchases = SUM(QTY*PRICE);
	END;
ELSE IF Food_Group_Code_1 = "04" THEN
	DO;
		_04_convenience_sizenew = SUM(QTY*SIZE_new);
		_04_convenience_sizemean = SUM(QTY*size_imputed_mean);
		_04_convenience_sizemedian = SUM(QTY*size_imputed_median);
		_04_convenience_sizemode = SUM(QTY*size_imputed_mode);
		_04_convenience_purchases = SUM(QTY*PRICE);
	END;
ELSE IF Food_Group_Code_1 = "05" THEN
	DO;
		_05_dairy_sizenew = SUM(QTY*SIZE_new);
		_05_dairy_sizemean = SUM(QTY*size_imputed_mean);
		_05_dairy_sizemedian = SUM(QTY*size_imputed_median);
		_05_dairy_sizemode = SUM(QTY*size_imputed_mode);
		_05_dairy_purchases = SUM(QTY*PRICE);
	END;
ELSE IF Food_Group_Code_1 = "06" THEN
	DO;
		_06_edibleoils_sizenew = SUM(QTY*SIZE_new);
		_06_edibleoils_sizemean = SUM(QTY*size_imputed_mean);
		_06_edibleoils_sizemedian = SUM(QTY*size_imputed_median);
		_06_edibleoils_sizemode = SUM(QTY*size_imputed_mode);
		_06_edibleoils_purchases = SUM(QTY*PRICE);
	END;
ELSE IF Food_Group_Code_1 = "07" THEN
	DO;
		_07_eggs_sizenew = SUM(QTY*SIZE_new);
		_07_eggs_sizemean = SUM(QTY*size_imputed_mean);
		_07_eggs_sizemedian = SUM(QTY*size_imputed_median);
		_07_eggs_sizemode = SUM(QTY*size_imputed_mode);
		_07_eggs_purchases = SUM(QTY*PRICE);
	END;
ELSE IF Food_Group_Code_1 = "08" THEN
	DO;
		_08_fish_sizenew = SUM(QTY*SIZE_new);
		_08_fish_sizemean = SUM(QTY*size_imputed_mean);
		_08_fish_sizemedian = SUM(QTY*size_imputed_median);
		_08_fish_sizemode = SUM(QTY*size_imputed_mode);
		_08_fish_purchases = SUM(QTY*PRICE);
	END;
ELSE IF Food_Group_Code_1 = "09" THEN
	DO;
		_09_fruitveges_sizenew = SUM(QTY*SIZE_new);
		_09_fruitveges_sizemean = SUM(QTY*size_imputed_mean);
		_09_fruitveges_sizemedian = SUM(QTY*size_imputed_median);
		_09_fruitveges_sizemode = SUM(QTY*size_imputed_mode);
		_09_fruitveges_purchases = SUM(QTY*PRICE);
	END;
ELSE IF Food_Group_Code_1 = "10" THEN
	DO;
		_10_meat_sizenew = SUM(QTY*SIZE_new);
		_10_meat_sizemean = SUM(QTY*size_imputed_mean);
		_10_meat_sizemedian = SUM(QTY*size_imputed_median);
		_10_meat_sizemode = SUM(QTY*size_imputed_mode);
		_10_meat_purchases = SUM(QTY*PRICE);
	END;
ELSE IF Food_Group_Code_1 = "11" THEN
	DO;
		_11_nonalcoholic_sizenew = SUM(QTY*SIZE_new);
		_11_nonalcoholic_sizemean = SUM(QTY*size_imputed_mean);
		_11_nonalcoholic_sizemedian = SUM(QTY*size_imputed_median);
		_11_nonalcoholic_sizemode = SUM(QTY*size_imputed_mode);
		_11_nonalcoholic_purchases = SUM(QTY*PRICE);
	END;
ELSE IF Food_Group_Code_1 = "12" THEN
	DO;
		_12_sauces_sizenew = SUM(QTY*SIZE_new);
		_12_sauces_sizemean = SUM(QTY*size_imputed_mean);
		_12_sauces_sizemedian = SUM(QTY*size_imputed_median);
		_12_sauces_sizemode = SUM(QTY*size_imputed_mode);
		_12_sauces_purchases = SUM(QTY*PRICE);
	END;
ELSE IF Food_Group_Code_1 = "13" THEN
	DO;
		_13_snackfoods_sizenew = SUM(QTY*SIZE_new);
		_13_snackfoods_sizemean = SUM(QTY*size_imputed_mean);
		_13_snackfoods_sizemedian = SUM(QTY*size_imputed_median);
		_13_snackfoods_sizemode = SUM(QTY*size_imputed_mode);
		_13_snackfoods_purchases = SUM(QTY*PRICE);
	END;
ELSE IF Food_Group_Code_1 = "14" THEN
	DO;
		_14_specialfoods_sizenew = SUM(QTY*SIZE_new);
		_14_specialfoods_sizemean = SUM(QTY*size_imputed_mean);
		_14_specialfoods_sizemedian = SUM(QTY*size_imputed_median);
		_14_specialfoods_sizemode = SUM(QTY*size_imputed_mode);
		_14_specialfoods_purchases = SUM(QTY*PRICE);
	END;
ELSE IF Food_Group_Code_1 = "15" THEN
	DO;
		_15_sugarhoney_sizenew = SUM(QTY*SIZE_new);
		_15_sugarhoney_sizemean = SUM(QTY*size_imputed_mean);
		_15_sugarhoney_sizemedian = SUM(QTY*size_imputed_median);
		_15_sugarhoney_sizemode = SUM(QTY*size_imputed_mode);
		_15_sugarhoney_purchases = SUM(QTY*PRICE);
	END;
ELSE IF Food_Group_Code_1 = "16" THEN
	DO;
		_16_alcohol_sizenew = SUM(QTY*SIZE_new);
		_16_alcohol_sizemean = SUM(QTY*size_imputed_mean);
		_16_alcohol_sizemedian = SUM(QTY*size_imputed_median);
		_16_alcohol_sizemode = SUM(QTY*size_imputed_mode);
		_16_alcohol_purchases = SUM(QTY*PRICE);
	END;
ELSE
	DO;
		_17_unclassified_sizenew = SUM(QTY*SIZE_new);
		_17_unclassified_sizemean = SUM(QTY*size_imputed_mean);
		_17_unclassified_sizemedian = SUM(QTY*size_imputed_median);
		_17_unclassified_sizemode = SUM(QTY*size_imputed_mode);
		_17_unclassified_purchases = SUM(QTY*PRICE);
	END;
RUN;

/* permanent file */
DATA cfoy.imputed_final_2013;
SET imputed_final_2013;
RUN;

/* Total expenditure and total purchased weight for each HH */
PROC SQL;
CREATE TABLE totalsperHH2013 AS
SELECT DISTINCT HH, Weight, Lifestage, Income_Group, HH_Size, Age_Group, Sex, Adults, Children, PostCode,

/* overall total exp and weight purchased */
	 SUM(QTY*PRICE) AS HH_Total_Expenditure,
	 SUM(QTY*SIZE_new) AS HH_SIZE_new_weight,
	 SUM(QTY*size_imputed_mean) AS HH_size_mean_weight,
	 SUM(QTY*size_imputed_median) AS HH_size_median_weight,
	 SUM(QTY*size_imputed_mode) AS HH_size_mode_weight,

/* LEVEL OF PROCESSING household exp and weight */
	SUM(Processing_0_sizenew) AS HH_Processing_0_sizenew,
	SUM(Processing_0_sizemean) AS HH_Processing_0_sizemean,
	SUM(Processing_0_sizemedian) AS HH_Processing_0_sizemedian,
	SUM(Processing_0_sizemode) AS HH_Processing_0_sizemode,
	SUM(Processing_0_purchases) AS HH_Processing_0_purchases,

	SUM(Processing_1_sizenew) AS HH_Processing_1_sizenew,
	SUM(Processing_1_sizemean) AS HH_Processing_1_sizemean,
	SUM(Processing_1_sizemedian) AS HH_Processing_1_sizemedian,
	SUM(Processing_1_sizemode) AS HH_Processing_1_sizemode,
	SUM(Processing_1_purchases) AS HH_Processing_1_purchases,

	SUM(Processing_2_sizenew) AS HH_Processing_2_sizenew,
	SUM(Processing_2_sizemean) AS HH_Processing_2_sizemean,
	SUM(Processing_2_sizemedian) AS HH_Processing_2_sizemedian,
	SUM(Processing_2_sizemode) AS HH_Processing_2_sizemode,
	SUM(Processing_2_purchases) AS HH_Processing_2_purchases,

	SUM(Processing_3_sizenew) AS HH_Processing_3_sizenew,
	SUM(Processing_3_sizemean) AS HH_Processing_3_sizemean,
	SUM(Processing_3_sizemedian) AS HH_Processing_3_sizemedian,
	SUM(Processing_3_sizemode) AS HH_Processing_3_sizemode,
	SUM(Processing_3_purchases) AS HH_Processing_3_purchases,

	SUM(Processing_4_sizenew) AS HH_Processing_4_sizenew,
	SUM(Processing_4_sizemean) AS HH_Processing_4_sizemean,
	SUM(Processing_4_sizemedian) AS HH_Processing_4_sizemedian,
	SUM(Processing_4_sizemode) AS HH_Processing_4_sizemode,
	SUM(Processing_4_purchases) AS HH_Processing_4_purchases,

/* FOOD GROUP LEVEL 1 household exp and weight */
	SUM(_01_bread_sizenew) AS HH_01_bread_sizenew,
	SUM(_01_bread_sizemean) AS HH_01_bread_sizemean,
	SUM(_01_bread_sizemedian) AS HH_01_bread_sizemedian,
	SUM(_01_bread_sizemode) AS HH_01_bread_sizemode,
	SUM(_01_bread_purchases) AS HH_01_bread_purchases,

	SUM(_02_cereal_sizenew) AS HH_02_cereal_sizenew,
	SUM(_02_cereal_sizemean) AS HH_02_cereal_sizemean,
	SUM(_02_cereal_sizemedian) AS HH_02_cereal_sizemedian,
	SUM(_02_cereal_sizemode) AS HH_02_cereal_sizemode,
	SUM(_02_cereal_purchases) AS HH_02_cereal_purchases,

	SUM(_03_confectionary_sizenew) AS HH_03_confectionary_sizenew,
	SUM(_03_confectionary_sizemean) AS HH_03_confectionary_sizemean,
	SUM(_03_confectionary_sizemedian) AS HH_03_confectionary_sizemedian,
	SUM(_03_confectionary_sizemode) AS HH_03_confectionary_sizemode,
	SUM(_03_confectionary_purchases) AS HH_03_confectionary_purchases,

	SUM(_04_convenience_sizenew) AS HH_04_convenience_sizenew,
	SUM(_04_convenience_sizemean) AS HH_04_convenience_sizemean,
	SUM(_04_convenience_sizemedian) AS HH_04_convenience_sizemedian,
	SUM(_04_convenience_sizemode) AS HH_04_convenience_sizemode,
	SUM(_04_convenience_purchases) AS HH_04_convenience_purchases,

	SUM(_05_dairy_sizenew) AS HH_05_dairy_sizenew,
	SUM(_05_dairy_sizemean) AS HH_05_dairy_sizemean,
	SUM(_05_dairy_sizemedian) AS HH_05_dairy_sizemedian,
	SUM(_05_dairy_sizemode) AS HH_05_dairy_sizemode,
	SUM(_05_dairy_purchases) AS HH_05_dairy_purchases,

	SUM(_06_edibleoils_sizenew) AS HH_06_edibleoils_sizenew,
	SUM(_06_edibleoils_sizemean) AS HH_06_edibleoils_sizemean,
	SUM(_06_edibleoils_sizemedian) AS HH_06_edibleoils_sizemedian,
	SUM(_06_edibleoils_sizemode) AS HH_06_edibleoils_sizemode,
	SUM(_06_edibleoils_purchases) AS HH_06_edibleoils_purchases,

	SUM(_07_eggs_sizenew) AS HH_07_eggs_sizenew,
	SUM(_07_eggs_sizemean) AS HH_07_eggs_sizemean,
	SUM(_07_eggs_sizemedian) AS HH_07_eggs_sizemedian,
	SUM(_07_eggs_sizemode) AS HH_07_eggs_sizemode,
	SUM(_07_eggs_purchases) AS HH__07_eggs_purchases,

	SUM(_08_fish_sizenew) AS HH_08_fish_sizenew,
	SUM(_08_fish_sizemean) AS HH_08_fish_sizemean,
	SUM(_08_fish_sizemedian) AS HH_08_fish_sizemedian,
	SUM(_08_fish_sizemode) AS HH_08_fish_sizemode,
	SUM(_08_fish_purchases) AS HH_08_fish_purchases,

	SUM(_09_fruitveges_sizenew) AS HH_09_fruitveges_sizenew,
	SUM(_09_fruitveges_sizemean) AS HH_09_fruitveges_sizemean,
	SUM(_09_fruitveges_sizemedian) AS HH_09_fruitveges_sizemedian,
	SUM(_09_fruitveges_sizemode) AS HH_09_fruitveges_sizemode,
	SUM(_09_fruitveges_purchases) AS HH_09_fruitveges_purchases,

	SUM(_10_meat_sizenew) AS HH_10_meat_sizenew,
	SUM(_10_meat_sizemean) AS HH_10_meat_sizemean,
	SUM(_10_meat_sizemedian) AS HH_10_meat_sizemedian,
	SUM(_10_meat_sizemode) AS HH_10_meat_sizemode,
	SUM(_10_meat_purchases) AS HH_10_meat_purchases,

	SUM(_11_nonalcoholic_sizenew) AS HH_11_nonalcoholic_sizenew,
	SUM(_11_nonalcoholic_sizemean) AS HH_11_nonalcoholic_sizemean,
	SUM(_11_nonalcoholic_sizemedian) AS HH_11_nonalcoholic_sizemedian,
	SUM(_11_nonalcoholic_sizemode) AS HH_11_nonalcoholic_sizemode,
	SUM(_11_nonalcoholic_purchases) AS HH_11_nonalcoholic_purchases,

	SUM(_12_sauces_sizenew) AS HH_12_sauces_sizenew,
	SUM(_12_sauces_sizemean) AS HH_12_sauces_sizemean,
	SUM(_12_sauces_sizemedian) AS HH_12_sauces_sizemedian,
	SUM(_12_sauces_sizemode) AS HH_12_sauces_sizemode,
	SUM(_12_sauces_purchases) AS HH_12_sauces_purchases,

	SUM(_13_snackfoods_sizenew) AS HH_13_snackfoods_sizenew,
	SUM(_13_snackfoods_sizemean) AS HH_13_snackfoods_sizemean,
	SUM(_13_snackfoods_sizemedian) AS HH_13_snackfoods_sizemedian,
	SUM(_13_snackfoods_sizemode) AS HH_13_snackfoods_sizemode,
	SUM(_13_snackfoods_purchases) AS HH_13_snackfoods_purchases,

	SUM(_14_specialfoods_sizenew) AS HH_14_specialfoods_sizenew,
	SUM(_14_specialfoods_sizemean) AS HH_14_specialfoods_sizemean,
	SUM(_14_specialfoods_sizemedian) AS HH_14_specialfoods_sizemedian,
	SUM(_14_specialfoods_sizemode) AS HH_14_specialfoods_sizemode,
	SUM(_14_specialfoods_purchases) AS HH_14_specialfoods_purchases,

	SUM(_15_sugarhoney_sizenew) AS HH_15_sugarhoney_sizenew,
	SUM(_15_sugarhoney_sizemean) AS HH_15_sugarhoney_sizemean,
	SUM(_15_sugarhoney_sizemedian) AS HH_15_sugarhoney_sizemedian,
	SUM(_15_sugarhoney_sizemode) AS HH_15_sugarhoney_sizemode,
	SUM(_15_sugarhoney_purchases) AS HH_15_sugarhoney_purchases,

	SUM(_16_alcohol_sizenew) AS HH_16_alcohol_sizenew,
	SUM(_16_alcohol_sizemean) AS HH_16_alcohol_sizemean,
	SUM(_16_alcohol_sizemedian) AS HH_16_alcohol_sizemedian,
	SUM(_16_alcohol_sizemode) AS HH_16_alcohol_sizemode,
	SUM(_16_alcohol_purchases) AS HH_16_alcohol_purchases,

	SUM(_17_unclassified_sizenew) AS HH_17_unclassified_sizenew,
	SUM(_17_unclassified_sizemean) AS HH_17_unclassified_sizemean,
	SUM(_17_unclassified_sizemedian)AS HH_17_unclassified_sizemedian,
	SUM(_17_unclassified_sizemode) AS HH_17_unclassified_sizemode,
	SUM(_17_unclassified_purchases) AS HH_17_unclassified_purchases

FROM imputed_final_2013
GROUP BY HH
ORDER BY HH;
QUIT;

/* create "year" column */
DATA totalsperHH2013;
SET totalsperHH2013;
Year = 2013;
RUN;

DATA totalsperHH2013;
RETAIN Year;
SET totalsperHH2013;
RUN;

/* permanent copy */
DATA cfoy.totalsperHH2013;
SET totalsperHH2013;
RUN;

DATA totalsperHH2013;
SET cfoy.totalsperHH2013;
RUN;
/****************************************************************/
/* END*/
