options nofmterr linesize=100 pagesize=55 nonumber nodate formchar = '|_';

%let drive = F:;	*	USB		;
%let todaysdate = %sysfunc(today(), ddmmyyn8.);
libname cfoy "&drive";

options nofmterr linesize=100 pagesize=55 YEARCUTOFF=1900 nonumber nodate formchar = '|_';
options mcompilenote=all mprint  mlogic;
/****************************************************************/
/* DEMOGRAPHICS GRAPHS - kg and $ (size_new) - 2 plots in one graph display */
/****************************************************************/
PROC FORMAT;
VALUE hhsizefmt 1 = '1 - 2'
            	2 = '3 - 4'
            	3 = '5 or above';

VALUE incgpfmt	1 = '$50,000 or less'
            	2 = '$50,001 - $90,000'
           	 	3 = 'More than $90,000';

VALUE agefmt	1 = 'Under 40 years'
            	2 = '40 - 65 years'
           	 	3 = 'Over 65 years'; 

VALUE lifefmt 	1 = 'Young Families'
				2 = 'Mixed Families'
				3 = 'Older Families'
				4 = 'Older Singles & Couples'
				5 = 'Adult Hoseholds Inc YSC';
RUN;

/* total expenditure ($) */
PROC IMPORT out=totalexp DATAFILE = "F:\x Honours Project\02 - Statistical analysis plan (SAP)\007 - IMPUTE - expenditure and weight for each HH per year\household_totals.xlsx"
DBMS = xlsx;
SHEET = "totalexp";
RUN;

/* total weight purchased (SIZE_new) (kg) */
PROC IMPORT out=totsizenew DATAFILE = "F:\x Honours Project\02 - Statistical analysis plan (SAP)\007 - IMPUTE - expenditure and weight for each HH per year\household_totals.xlsx"
DBMS = xlsx;
SHEET = "totalsizenew";
RUN;

/** get the upper and lower limits of the mean (mean +- SEM*t) where t = 1.96 for 95% confidence **/
DATA totalexp;
SET totalexp;
FORMAT lower BEST12.;
FORMAT upper BEST12.;
lower = mean - (1.96*StdErr);
upper = mean + (1.96*StdErr);
RUN;
DATA totalexp;
RETAIN DomainLabel Year VarName N Mean lower upper;
SET totalexp;
RUN;

/** set up the data for individual plots **/
DATA totalexp;
SET totalexp;
IF incgp_cat = 1 THEN inc_1 = mean;
ELSE IF incgp_cat = 2 THEN inc_2 = mean;
ELSE IF incgp_cat = 3 THEN inc_3 = mean;

IF Sex_cat = "Female" THEN sex_fem = mean;
ELSE IF Sex_cat = "Male" THEN sex_male = mean;

IF agegp_cat = 1 THEN age_1 = mean;
ELSE IF agegp_cat = 2 THEN age_2 = mean;
ELSE IF agegp_cat = 3 THEN age_3 = mean;

IF life_cat = 1 THEN life_1 = mean;
ELSE IF life_cat = 2 THEN life_2 = mean;
ELSE IF life_cat = 3 THEN life_3 = mean;
ELSE IF life_cat = 4 THEN life_4 = mean;
ELSE IF life_cat = 5 THEN life_5 = mean;

IF hhsize_cat = 1 THEN hhsize_1 = mean;
ELSE IF hhsize_cat = 2 THEN hhsize_2 = mean;
ELSE IF hhsize_cat = 3 THEN hhsize_3 = mean;
RUN;

DATA totsizenew;
SET totsizenew;
FORMAT lower BEST12.;
FORMAT upper BEST12.;
lower = mean - (1.96*StdErr);
upper = mean + (1.96*StdErr);
RUN;
DATA totsizenew;
RETAIN DomainLabel Year VarName N Mean lower upper;
SET totsizenew;
RUN;
DATA totsizenew;
SET totsizenew;
IF incgp_cat = 1 THEN inc_1 = mean;
ELSE IF incgp_cat = 2 THEN inc_2 = mean;
ELSE IF incgp_cat = 3 THEN inc_3 = mean;

IF Sex_cat = "Female" THEN sex_fem = mean;
ELSE IF Sex_cat = "Male" THEN sex_male = mean;

IF agegp_cat = 1 THEN age_1 = mean;
ELSE IF agegp_cat = 2 THEN age_2 = mean;
ELSE IF agegp_cat = 3 THEN age_3 = mean;

IF life_cat = 1 THEN life_1 = mean;
ELSE IF life_cat = 2 THEN life_2 = mean;
ELSE IF life_cat = 3 THEN life_3 = mean;
ELSE IF life_cat = 4 THEN life_4 = mean;
ELSE IF life_cat = 5 THEN life_5 = mean;

IF hhsize_cat = 1 THEN hhsize_1 = mean;
ELSE IF hhsize_cat = 2 THEN hhsize_2 = mean;
ELSE IF hhsize_cat = 3 THEN hhsize_3 = mean;
RUN;

/********************************/
/** household income group **/
/* $ */
PROC SGPLOT DATA = totalexp(WHERE =(incgp_cat in (1,2,3)));
TITLE "Mean annual household total expenditure ($) by household income group";
	SERIES x = Year y = inc_1 / lineattrs = (color=blue pattern=solid) LEGENDLABEL = " ";
	SERIES x = Year y = inc_2 / lineattrs = (color=red pattern=dash) LEGENDLABEL = " ";
	SERIES x = Year y = inc_3 / lineattrs = (color=green pattern=dot) LEGENDLABEL = " ";
	SCATTER x = Year y = inc_1 /yerrorlower=lower yerrorupper=upper markerattrs=(color = blue symbol = dot) errorbarattrs=(color=blue pattern=solid) LEGENDLABEL = "$50,000 or less" name="inc1";
	SCATTER x = Year y = inc_2 /yerrorlower=lower yerrorupper=upper markerattrs=(color = red symbol = triangle) errorbarattrs=(color=red pattern=dash) LEGENDLABEL = "$50,001 - $90,000" name="inc2";
	SCATTER x = Year y = inc_3 /yerrorlower=lower yerrorupper=upper markerattrs=(color = green symbol = squarefilled) errorbarattrs=(color=green pattern=dot) LEGENDLABEL = "More than $90,000" name="inc3";
	LABEL year = "Year";
	YAXIS LABEL = "Mean annual household total expenditure ($)";
	KEYLEGEND "inc1" "inc2" "inc3";
	RUN;

/* kg */
PROC SGPLOT DATA = totsizenew(WHERE =(incgp_cat in (1,2,3)));
TITLE "Total mean weight purchased (kg) by Household Income Group";
	SERIES x = Year y = inc_1 / lineattrs = (color=blue pattern=solid);
	SERIES x = Year y = inc_2 / lineattrs = (color=red pattern=dash);
	SERIES x = Year y = inc_3 / lineattrs = (color=green pattern=dot);
	SCATTER x = Year y = inc_1 / yerrorlower=lower yerrorupper=upper markerattrs=(color = blue symbol = dot) errorbarattrs=(color=blue pattern=solid) LEGENDLABEL = "$50,000 or less" name="inc1";
	SCATTER x = Year y = inc_2 /yerrorlower=lower yerrorupper=upper markerattrs=(color = red symbol = triangle) errorbarattrs=(color=red pattern=dash) LEGENDLABEL = "$50,001 - $90,000" name="inc2";
	SCATTER x = Year y = inc_3 /yerrorlower=lower yerrorupper=upper markerattrs=(color = green symbol = squarefilled) errorbarattrs=(color=green pattern=dot) LEGENDLABEL = "More than $90,000" name="inc3";
	LABEL year = "Year";
	YAXIS LABEL = "Mean annual household total weight purchased (kg)";
	KEYLEGEND "inc1" "inc2" "inc3";
RUN;
QUIT;



/********************************/
/* lifestage group */
/* $ */
PROC SGPLOT DATA = totalexp(WHERE =(life_cat in (1,2,3,4,5)));
TITLE "Mean annual household total expenditure ($) by household life-stage group";
	SERIES x = Year y = life_1 / lineattrs = (color=blue pattern=solid);
	SERIES x = Year y = life_2 / lineattrs = (color=red pattern=dash);
	SERIES x = Year y = life_3 / lineattrs = (color=green pattern=dot);
	SERIES x = Year y = life_4 / lineattrs = (color=gold pattern=mediumdashshortdash);
	SERIES x = Year y = life_5 / lineattrs = (color=aqua pattern=longdash);
	SCATTER x = Year y = life_1 /yerrorlower=lower yerrorupper=upper markerattrs=(color = blue symbol = dot) errorbarattrs=(color=blue pattern=solid) LEGENDLABEL = "Young Families" name = "life1";
	SCATTER x = Year y = life_2 /yerrorlower=lower yerrorupper=upper markerattrs=(color = red symbol = triangle) errorbarattrs=(color=red pattern=dash) LEGENDLABEL = "Mixed Families" name = "life2";
	SCATTER x = Year y = life_4 /yerrorlower=lower yerrorupper=upper markerattrs=(color = gold symbol = x) errorbarattrs=(color=gold pattern=mediumdashshortdash) LEGENDLABEL = "Older Singles & Couples" name = "life4";
	SCATTER x = Year y = life_5 /yerrorlower=lower yerrorupper=upper markerattrs=(color = aqua symbol = circlefilled) errorbarattrs=(color=aqua pattern=longdash) LEGENDLABEL = "Adult Households Inc YSC" name = "life5";
	SCATTER x = Year y = life_3 /yerrorlower=lower yerrorupper=upper markerattrs=(color = green symbol = squarefilled) errorbarattrs=(color=green pattern=dot) LEGENDLABEL = "Older Families" name = "life3";
	LABEL year = "Year";
	YAXIS LABEL = "Mean annual household total expenditure ($)";
	KEYLEGEND "life1" "life2" "life3" "life4" "life5";
RUN;
QUIT;

/* kg */
PROC SGPLOT DATA = totsizenew(WHERE =(life_cat in (1,2,3,4,5)));
TITLE "Total mean weight purchased (kg) by Household Lifestage Group";
	SERIES x = Year y = life_1 / lineattrs = (color=blue pattern=solid);
	SERIES x = Year y = life_2 / lineattrs = (color=red pattern=dash);
	SERIES x = Year y = life_3 / lineattrs = (color=green pattern=dot);
	SERIES x = Year y = life_4 / lineattrs = (color=gold pattern=mediumdashshortdash);
	SERIES x = Year y = life_5 / lineattrs = (color=aqua pattern=longdash);
	SCATTER x = Year y = life_1 /yerrorlower=lower yerrorupper=upper markerattrs=(color = blue symbol = dot) errorbarattrs=(color=blue pattern=solid) LEGENDLABEL = "Young Families" name = "life1";
	SCATTER x = Year y = life_2 /yerrorlower=lower yerrorupper=upper markerattrs=(color = red symbol = triangle) errorbarattrs=(color=red pattern=dash) LEGENDLABEL = "Mixed Families" name = "life2";
	SCATTER x = Year y = life_4 /yerrorlower=lower yerrorupper=upper markerattrs=(color = gold symbol = x) errorbarattrs=(color=gold pattern=mediumdashshortdash) LEGENDLABEL = "Older Singles & Couples" name = "life4";
	SCATTER x = Year y = life_5 /yerrorlower=lower yerrorupper=upper markerattrs=(color = aqua symbol = circlefilled) errorbarattrs=(color=aqua pattern=longdash) LEGENDLABEL = "Adult Households Inc YSC" name = "life5";
	SCATTER x = Year y = life_3 /yerrorlower=lower yerrorupper=upper markerattrs=(color = green symbol = squarefilled) errorbarattrs=(color=green pattern=dot) LEGENDLABEL = "Older Families" name = "life3";
	LABEL year = "Year";
	YAXIS LABEL = "Mean annual household total weight purchased (kg)";
	KEYLEGEND "life1" "life2" "life3" "life4" "life5";
RUN;
QUIT;



/********************************/
/* hh size group */
/* $ */
PROC SGPLOT DATA = totalexp(WHERE =(hhsize_cat in (1,2,3)));
TITLE "Mean annual household total expenditure ($) by household size";
	SERIES x = Year y = hhsize_1 / lineattrs = (color=blue pattern=solid);
	SERIES x = Year y = hhsize_2 / lineattrs = (color=red pattern=dash);
	SERIES x = Year y = hhsize_3 / lineattrs = (color=green pattern=dot);
	SCATTER x = Year y = hhsize_1 /yerrorlower=lower yerrorupper=upper markerattrs=(color = blue symbol = dot) errorbarattrs=(color=blue pattern=solid) LEGENDLABEL = "1 - 2" name = "hhsize1";
	SCATTER x = Year y = hhsize_2 /yerrorlower=lower yerrorupper=upper markerattrs=(color = red symbol = triangle) errorbarattrs=(color=red pattern=dash) LEGENDLABEL = "3 - 4" name = "hhsize2";
	SCATTER x = Year y = hhsize_3 /yerrorlower=lower yerrorupper=upper markerattrs=(color = green symbol = squarefilled) errorbarattrs=(color=green pattern=dot) LEGENDLABEL = "5 or above" name = "hhsize3";
	LABEL year = "Year";
	YAXIS LABEL = "Mean annual household total expenditure ($)";
	KEYLEGEND "hhsize1" "hhsize2" "hhsize3";
RUN;
QUIT;

PROC SGPLOT DATA = totsizenew(WHERE =(hhsize_cat in (1,2,3)));
TITLE "Total mean weight purchased (kg) by Household Size";
	SERIES x = Year y = hhsize_1 / lineattrs = (color=blue pattern=solid);
	SERIES x = Year y = hhsize_2 / lineattrs = (color=red pattern=dash);
	SERIES x = Year y = hhsize_3 / lineattrs = (color=green pattern=dot);
	SCATTER x = Year y = hhsize_1 /yerrorlower=lower yerrorupper=upper markerattrs=(color = blue symbol = dot) errorbarattrs=(color=blue pattern=solid) LEGENDLABEL = "1 - 2" name = "hhsize1";
	SCATTER x = Year y = hhsize_2 /yerrorlower=lower yerrorupper=upper markerattrs=(color = red symbol = triangle) errorbarattrs=(color=red pattern=dash) LEGENDLABEL = "3 - 4" name = "hhsize2";
	SCATTER x = Year y = hhsize_3 /yerrorlower=lower yerrorupper=upper markerattrs=(color = green symbol = squarefilled) errorbarattrs=(color=green pattern=dot) LEGENDLABEL = "5 or above" name = "hhsize3";
	LABEL year = "Year";
	YAXIS LABEL = "Mean annual household total weight purchased (kg)";
	KEYLEGEND "hhsize1" "hhsize2" "hhsize3";
RUN;
QUIT;
