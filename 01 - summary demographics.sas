/*************************************************/
/* SUMMARY DEMOGRAPHICS - HOUSEHOLDS AND BY YEAR */
/**** (using demogs_year.xlsx files) (USB) ****/
/*************************************************/

/* setting up: EXCEL demographics in USB imported as .sas7bdat files*/
TITLE1 "Demographics Summary Statistics";
LIBNAME cfoy "F:";


/* 2012 demographics: import EXCEL */
PROC IMPORT OUT = CFOY.demog_2012 
            DATAFILE= "F:\x Honours Project\001 - Demographic data\DEMOG
S_7Oct2012.xlsx" 
            DBMS=EXCELCS REPLACE;
     RANGE="Sheet2$"; 
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

/* CREATE HTML FILE for Demographics - 2012 */
ODS HTML BODY = "2012demographics-body.html"
CONTENTS = "2012demographics-contents.html"
FRAME = "2012demographics-frame.html";

/* allows objects to be outputted into HTML */
ODS GRAPHICS ON;

/* prints whole dataset; 1,482 obs and 9 vars */
PROC PRINT DATA = cfoy.demog_2012;
TITLE 'Demographics (2012)';
RUN;

PROC CONTENTS DATA = cfoy.demog_2012;
TITLE 'Demographics (2012): Contents';
RUN;

/* total number of adults (unstandardized) and children */
PROC SUMMARY DATA = cfoy.demog_2012;
VAR Adults Children;
output out=ProcSumOut sum =;
RUN;
PROC PRINT DATA = work.procsumout;
TITLE 'Demographics (2012): Total number of adults (unstandardized) and children';
RUN;

/* total number of individuals (adults + children) (unstandardized) */
PROC MEANS DATA = cfoy.demog_2012 SUM;
VAR HH_Size;
TITLE 'Demographics (2012): Total number of individuals (Adults and Children)';
RUN;

/* lifestage of primary shopper 2012 frequency table and bar chart */
PROC FREQ DATA = cfoy.demog_2012;
TABLES Lifestage / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2012): Lifestage Sample Distribution';
RUN;

/* household income group 2012 frequency table and bar chart */
PROC FREQ DATA = cfoy.demog_2012;
TABLES Income_Group / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2012): Household Income group Sample Distribution';
RUN;

/* household size 2012 summary statistics */
PROC UNIVARIATE DATA = cfoy.demog_2012 CIBASIC;
VAR HH_Size;
HISTOGRAM HH_Size / endpoints = 1 to 11 by 1;
TITLE 'Demographics (2012): Household Size summary statistics';
RUN;
PROC FREQ DATA = cfoy.demog_2012;
TABLES HH_Size;
TITLE 'Demographics (2012): Household Size frequency table';
RUN;

/* age group of primary shopper 2012 frequency table and bar chart */
PROC FREQ DATA = cfoy.demog_2012;
TABLES Age_Group / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2012): Age group Sample Distribution';
RUN;

/* sex of primary shopper income group 2012 frequency table and bar chart */
PROC FORMAT;
VALUE gender
1 = "Male"
2 = "Female";
RUN;

PROC FREQ DATA = cfoy.demog_2012;
FORMAT Sex gender.;
TABLES Sex / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2012): Sex Sample Distribution';
RUN;

/* number of adults household 2012 summary statistics */
PROC UNIVARIATE DATA = cfoy.demog_2012 CIBASIC;
VAR Adults;
HISTOGRAM Adults / endpoints = 1 to 9 by 1;
TITLE 'Demographics (2012): Number of Adults summary statistics';
RUN;

PROC FREQ DATA = cfoy.demog_2012;
TABLES Adults;
TITLE 'Demographics (2012): Number of Adults frequency table';
RUN;

/* number of children household 2012 summary statistics */
PROC UNIVARIATE DATA = cfoy.demog_2012 CIBASIC;
VAR Children;
HISTOGRAM Children / endpoints = 1 to 8 by 1;
TITLE 'Demographics (2012): Number of Children summary statistics';
RUN;

PROC FREQ DATA = cfoy.demog_2012;
TABLES Children;
TITLE 'Demographics (2012): Number of Children frequency table';
RUN;

/* close the HTML file*/
ODS GRAPHICS OFF;
ODS HTML CLOSE;








/*****************************************************************/
/* 2013 demographics: import EXCEL */
PROC IMPORT OUT= CFOY.demog_2013
            DATAFILE= "E:\x Honours Project\001 - Demographic data\DEMOG
S_6oct2013.xlsx" 
            DBMS=EXCELCS REPLACE;
     RANGE="Sheet2$"; 
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

/* CREATE HTML FILE for Demographics - 2013 */
ODS HTML BODY = "2013demographics-body.html"
CONTENTS = "2013demographics-contents.html"
FRAME = "2013demographics-frame.html";

/* allows objects to be outputted into HTML */
ODS GRAPHICS ON;

/* prints whole table = 1,700 households and 9 vars */
PROC PRINT DATA = cfoy.demog_2013;
TITLE 'Demographics (2013)';
RUN;

PROC CONTENTS DATA = cfoy.demog_2013;
TITLE 'Demographics (2013): Contents';
RUN;

/* total number of adults (unstandardized) and children */
PROC SUMMARY DATA = cfoy.demog_2013;
VAR Adults Children;
output out = ProcSumOut sum =;
RUN;
PROC PRINT DATA = work.ProcSumOut;
TITLE 'Demographics (2013): Total number of adults (unstandardized) and children';
RUN;

/* total number of individuals (adults + children) (unstandardized) */
PROC MEANS DATA = cfoy.demog_2013 SUM;
VAR HH_Size;
TITLE 'Demographics (2013): Total number of individuals (Adults and Children)';
RUN;

/* lifestage of primary shopper 2013 frequency table and bar chart */
PROC FREQ DATA = cfoy.demog_2013;
TABLES Lifestage / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2013): Lifestage Sample Distribution';
RUN;

/* household income group 2013 frequency table and bar chart */
PROC FREQ DATA = cfoy.demog_2013;
TABLES Income_Group / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2013): Household Income group Sample Distribution';
RUN;

/* household size 2013 summary statistics */
PROC UNIVARIATE DATA = cfoy.demog_2013 CIBASIC;
VAR HH_Size;
HISTOGRAM HH_Size / endpoints = 1 to 11 by 1;
TITLE 'Demographics (2013): Household Size summary statistics';
RUN;
PROC FREQ DATA = cfoy.demog_2013;
TABLES HH_Size;
TITLE 'Demographics (2013): Household Size frequency table';
RUN;

/* age group of primary shopper 2013 frequency table and bar chart */
PROC FREQ DATA = cfoy.demog_2013;
TABLES Age_Group / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2013): Age group Sample Distribution';
RUN;

/* sex of primary shopper income group 2013 frequency table and bar chart */
PROC FORMAT;
VALUE gender
1 = "Male"
2 = "Female";
RUN;

PROC FREQ DATA = cfoy.demog_2013;
FORMAT Sex gender.;
TABLES Sex / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2013): Sex Sample Distribution';
RUN;

/* number of adults household 2013 summary statistics */
PROC UNIVARIATE DATA = cfoy.demog_2013 CIBASIC;
VAR Adults;
HISTOGRAM Adults / endpoints = 1 to 8 by 1;
TITLE 'Demographics (2013): Number of Adults summary statistics';
RUN;

PROC FREQ DATA = cfoy.demog_2013;
TABLES Adults;
TITLE 'Demographics (2013): Number of Adults frequency table';
RUN;

/* number of children household 2013 summary statistics */
PROC UNIVARIATE DATA = cfoy.demog_2013 CIBASIC;
VAR Children;
HISTOGRAM Children / endpoints = 1 to 8 by 1;
TITLE 'Demographics (2013): Number of Children summary statistics';
RUN;

PROC FREQ DATA = cfoy.demog_2013;
TABLES Children;
TITLE 'Demographics (2013): Number of Children frequency table';
RUN;

/* close the HTML file*/
ODS GRAPHICS OFF;
ODS HTML CLOSE;








/*****************************************************************/
/* 2014 demographics: import EXCEL */
PROC IMPORT OUT= CFOY.demog_2014
            DATAFILE= "E:\x Honours Project\001 - Demographic data\DEMOG
S_5oct2014.xlsx" 
            DBMS=EXCELCS REPLACE;
     RANGE="Sheet1$"; 
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

/* CREATE HTML FILE for Demographics - 2014 */
ODS HTML BODY = "2014demographics-body.html"
CONTENTS = "2014demographics-contents.html"
FRAME = "2014demographics-frame.html";

/* allows objects to be outputted into HTML */
ODS GRAPHICS ON;

/* prints whole table = 1,726 households and 9 vars */
PROC PRINT DATA = cfoy.demog_2014;
TITLE 'Demographics (2014)';
RUN;

PROC CONTENTS DATA = cfoy.demog_2014;
TITLE 'Demographics (2014): Contents';
RUN;

/* total number of adults (unstandardized) and children */
PROC SUMMARY DATA = cfoy.demog_2014;
VAR Adults Children;
output out = ProcSumOut sum =;
RUN;
PROC PRINT DATA = work.ProcSumOut;
TITLE 'Demographics (2014): Total number of adults (unstandardized) and children';
RUN;

/* total number of individuals (adults + children) (unstandardized) */
PROC MEANS DATA = cfoy.demog_2014 SUM;
VAR HH_Size;
TITLE 'Demographics (2014): Total number of individuals (Adults and Children)';
RUN;

/* lifestage of primary shopper 2014 frequency table and bar chart */
PROC FREQ DATA = cfoy.demog_2014;
TABLES Lifestage / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2014): Lifestage Sample Distribution';
RUN;

/* household income group 2014 frequency table and bar chart */
PROC FREQ DATA = cfoy.demog_2014;
TABLES Income_Group / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2014): Household Income group Sample Distribution';
RUN;

/* household size 2014 summary statistics */
PROC UNIVARIATE DATA = cfoy.demog_2014 CIBASIC;
VAR HH_Size;
HISTOGRAM HH_Size / endpoints = 1 to 13 by 1;
TITLE 'Demographics (2014): Household Size summary statistics';
RUN;
PROC FREQ DATA = cfoy.demog_2014;
TABLES HH_Size;
TITLE 'Demographics (2014): Household Size frequency table';
RUN;

/* age group of primary shopper 2014 frequency table and bar chart */
PROC FREQ DATA = cfoy.demog_2014;
TABLES Age_Group / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2014): Age group Sample Distribution';
RUN;

/* sex of primary shopper income group 2014 frequency table and bar chart */
PROC FORMAT;
VALUE gender
1 = "Male"
2 = "Female";
RUN;

PROC FREQ DATA = cfoy.demog_2014;
FORMAT Sex gender.;
TABLES Sex / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2014): Sex Sample Distribution';
RUN;

/* number of adults household 2014 summary statistics */
PROC UNIVARIATE DATA = cfoy.demog_2014 CIBASIC;
VAR Adults;
HISTOGRAM Adults / endpoints = 1 to 9 by 1;
TITLE 'Demographics (2014): Number of Adults summary statistics';
RUN;

PROC FREQ DATA = cfoy.demog_2014;
TABLES Adults;
TITLE 'Demographics (2014): Number of Adults frequency table';
RUN;

/* number of children household 2014 summary statistics */
PROC UNIVARIATE DATA = cfoy.demog_2014 CIBASIC;
VAR Children;
HISTOGRAM Children / endpoints = 1 to 7 by 1;
TITLE 'Demographics (2014): Number of Children summary statistics';
RUN;

PROC FREQ DATA = cfoy.demog_2014;
TABLES Children;
TITLE 'Demographics (2014): Number of Children frequency table';
RUN;

/* close the HTML file*/
ODS GRAPHICS OFF;
ODS HTML CLOSE;



/*****************************************************************/
/* 2015 demographics: import EXCEL */
PROC IMPORT OUT= CFOY.demog_2015
            DATAFILE= "E:\x Honours Project\001 - Demographic data\DEMOG
S_4oct2015.xlsx" 
            DBMS=EXCELCS REPLACE;
     RANGE="Sheet1$"; 
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

/* CREATE HTML FILE for Demographics - 2015 */
ODS HTML BODY = "2015demographics-body.html"
CONTENTS = "2015demographics-contents.html"
FRAME = "2015demographics-frame.html";

/* allows objects to be outputted into HTML */
ODS GRAPHICS ON;

/* prints whole table = 1,827 households and 9 vars */
PROC PRINT DATA = cfoy.demog_2015;
TITLE 'Demographics (2015)';
RUN;

PROC CONTENTS DATA = cfoy.demog_2015;
TITLE 'Demographics (2015): Contents';
RUN;

/* total number of adults (unstandardized) and children */
PROC SUMMARY DATA = cfoy.demog_2015;
VAR Adults Children;
output out = ProcSumOut sum =;
RUN;
PROC PRINT DATA = work.ProcSumOut;
TITLE 'Demographics (2015): Total number of adults (unstandardized) and children';
RUN;

/* total number of individuals (adults + children) (unstandardized) */
PROC MEANS DATA = cfoy.demog_2015 SUM;
VAR HH_Size;
TITLE 'Demographics (2015): Total number of individuals (Adults and Children)';
RUN;

/* lifestage of primary shopper 2015 frequency table and bar chart */
PROC FREQ DATA = cfoy.demog_2015;
TABLES Lifestage / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2015): Lifestage Sample Distribution';
RUN;

/* household income group 2015 frequency table and bar chart */
PROC FREQ DATA = cfoy.demog_2015;
TABLES Income_Group / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2015): Household Income group Sample Distribution';
RUN;

/* household size 2015 summary statistics */
PROC UNIVARIATE DATA = cfoy.demog_2015 CIBASIC;
VAR HH_Size;
HISTOGRAM HH_Size / endpoints = 1 to 13 by 1;
TITLE 'Demographics (2015): Household Size summary statistics';
RUN;
PROC FREQ DATA = cfoy.demog_2015;
TABLES HH_Size;
TITLE 'Demographics (2015): Household Size frequency table';
RUN;

/* age group of primary shopper 2015 frequency table and bar chart */
PROC FREQ DATA = cfoy.demog_2015;
TABLES Age_Group / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2015): Age group Sample Distribution';
RUN;

/* sex of primary shopper income group 2015 frequency table and bar chart */
PROC FORMAT;
VALUE gender
1 = "Male"
2 = "Female";
RUN;

PROC FREQ DATA = cfoy.demog_2015;
FORMAT Sex gender.;
TABLES Sex / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2015): Sex Sample Distribution';
RUN;

/* number of adults household 2015 summary statistics */
PROC UNIVARIATE DATA = cfoy.demog_2015 CIBASIC;
VAR Adults;
HISTOGRAM Adults / endpoints = 1 to 9 by 1;
TITLE 'Demographics (2015): Number of Adults summary statistics';
RUN;

PROC FREQ DATA = cfoy.demog_2015;
TABLES Adults;
TITLE 'Demographics (2015): Number of Adults frequency table';
RUN;

/* number of children household 2015 summary statistics */
PROC UNIVARIATE DATA = cfoy.demog_2015 CIBASIC;
VAR Children;
HISTOGRAM Children / endpoints = 1 to 7 by 1;
TITLE 'Demographics (2015): Number of Children summary statistics';
RUN;

PROC FREQ DATA = cfoy.demog_2015;
TABLES Children;
TITLE 'Demographics (2015): Number of Children frequency table';
RUN;

/* close the HTML file*/
ODS GRAPHICS OFF;
ODS HTML CLOSE;








/*****************************************************************/
/* 2016 demographics: import EXCEL */
PROC IMPORT OUT= CFOY.demog_2016
            DATAFILE= "E:\x Honours Project\001 - Demographic data\DEMOG
S_2oct2016.xlsx" 
            DBMS=EXCELCS REPLACE;
     RANGE="Sheet1$"; 
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

/* CREATE HTML FILE for Demographics - 2016 */
ODS HTML BODY = "2016demographics-body.html"
CONTENTS = "2016demographics-contents.html"
FRAME = "2016demographics-frame.html";

/* allows objects to be outputted into HTML */
ODS GRAPHICS ON;

/* prints whole table = 1,839 households and 9 vars */
PROC PRINT DATA = cfoy.demog_2016;
TITLE 'Demographics (2016)';
RUN;

PROC CONTENTS DATA = cfoy.demog_2016;
TITLE 'Demographics (2016): Contents';
RUN;

/* total number of adults (unstandardized) and children */
PROC SUMMARY DATA = cfoy.demog_2016;
VAR Adults Children;
output out = ProcSumOut sum =;
RUN;
PROC PRINT DATA = work.ProcSumOut;
TITLE 'Demographics (2016): Total number of adults (unstandardized) and children';
RUN;

/* total number of individuals (adults + children) (unstandardized) */
PROC MEANS DATA = cfoy.demog_2016 SUM;
VAR HH_Size;
TITLE 'Demographics (2016): Total number of individuals (Adults and Children)';
RUN;

/* lifestage of primary shopper 2016 frequency table and bar chart */
PROC FREQ DATA = cfoy.demog_2016;
TABLES Lifestage / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2016): Lifestage Sample Distribution';
RUN;

/* household income group 2016 frequency table and bar chart */
PROC FREQ DATA = cfoy.demog_2016;
TABLES Income_Group / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2016): Household Income group Sample Distribution';
RUN;

/* household size 2016 summary statistics */
PROC UNIVARIATE DATA = cfoy.demog_2016 CIBASIC;
VAR HH_Size;
HISTOGRAM HH_Size / endpoints = 1 to 10 by 1;
TITLE 'Demographics (2016): Household Size summary statistics';
RUN;
PROC FREQ DATA = cfoy.demog_2016;
TABLES HH_Size;
TITLE 'Demographics (2016): Household Size frequency table';
RUN;

/* age group of primary shopper 2016 frequency table and bar chart */
PROC FREQ DATA = cfoy.demog_2016;
TABLES Age_Group / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2016): Age group Sample Distribution';
RUN;

/* sex of primary shopper income group 2016 frequency table and bar chart */
PROC FORMAT;
VALUE gender
1 = "Male"
2 = "Female";
RUN;

PROC FREQ DATA = cfoy.demog_2016;
FORMAT Sex gender.;
TABLES Sex / PLOTS = FreqPlot(scale=Percent);
TITLE 'Demographics (2016): Sex Sample Distribution';
RUN;

/* number of adults household 2016 summary statistics */
PROC UNIVARIATE DATA = cfoy.demog_2016 CIBASIC;
VAR Adults;
HISTOGRAM Adults / endpoints = 1 to 8 by 1;
TITLE 'Demographics (2016): Number of Adults summary statistics';
RUN;

PROC FREQ DATA = cfoy.demog_2016;
TABLES Adults;
TITLE 'Demographics (2016): Number of Adults frequency table';
RUN;

/* number of children household 2016 summary statistics */
PROC UNIVARIATE DATA = cfoy.demog_2016 CIBASIC;
VAR Children;
HISTOGRAM Children / endpoints = 1 to 8 by 1;
TITLE 'Demographics (2016): Number of Children summary statistics';
RUN;

PROC FREQ DATA = cfoy.demog_2016;
TABLES Children;
TITLE 'Demographics (2016): Number of Children frequency table';
RUN;

/* close the HTML file*/
ODS GRAPHICS OFF;
ODS HTML CLOSE;


/******************** END **************************/
