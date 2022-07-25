* Encoding: UTF-8.

*This file contains the syntax for a portion of the cleaning and analyses run in SPSS on experimental data from my Master's Thesis project.
*More information about the project can be found written up here: https://commons.lib.jmu.edu/masters202029/113/

*But here's some brief context:
  *The project investigated the effect of spacing between episodes of a Netflix show on memory for show content.
  *It was a 2 (Massed, Spaced) x 2 (1-week, 4-week) between subjects design

  *Massed groups viewed 3 1-hour long episodes back-to-back with no break (i.e., 'Binge-watching')
  *Spaced groups viewed the same 3 episodes, but with one week inbetween each viewing
  *Time of test was added as an additional variable, with some participants being tested at a 1-week delay and others at a 4-week delay

  *The test consisted of 40 questions assessing participant memory for show content, 35 were multiple choice, 5 were short answer


************************************ CLEANING AND COMBINING EXCEL FILES FROM QUALTRICS ************************************
 
*Getting started...
*8 Excel files were exported from Qualtrics, each holding data from a different experimental condition
*S = spaced, M = Massed, 1 = one-week delay, 4 = four-week delay, V1 = test version 1, V2 = test version 2
*So 'S1V1' refers to the Spaced one-week delay group who took test version 1


************************************S1V1.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Spaced 1 Week Vers1_April 2, 2021_09.37.sav".
exe.

dataset name S1V1.

delete vars StartDate to Progress Finished to Q40.
rename variables (Q23=SA_1)(Q24=SA_2)(Q27=SA_3)(Q28=SA_4)(Q37=SA_5).

string SA_6 (A2000) SA_7(A2000) SA_8(A2000) SA_9(A2000) SA_10(A2000).
compute condition = 1.
compute quiz_version = 1.
exe.

************************************S1V2.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Spaced 1 Week Vers2_April 2, 2021_09.38.sav".
exe.

dataset name S1V2.

delete vars StartDate to Progress Finished to Q37.
rename variables (Q21=SA_6)(Q29=SA_7)(Q36=SA_8)(Q38=SA_9)(Q40=SA_10).

string SA_1 (A2000) SA_2(A2000) SA_3(A2000) SA_4(A2000) SA_5(A2000).
compute condition = 1.
compute quiz_version = 2.
exe.


************************************S4V1.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Spaced 4 Week Vers1_April 2, 2021_09.36.sav".

dataset name S4V1.

delete vars StartDate to Progress Finished to Q40.
rename variables (Q23=SA_1)(Q24=SA_2)(Q27=SA_3)(Q28=SA_4)(Q37=SA_5).

string SA_6 (A2000) SA_7(A2000) SA_8(A2000) SA_9(A2000) SA_10(A2000).
compute condition = 2.
compute quiz_version = 1.
exe.

************************************S4V2.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Spaced 4 Week Vers2_April 2, 2021_09.37.sav".

dataset name S4V2.

delete vars StartDate to Progress Finished to Q37.
rename variables (Q21=SA_6)(Q29=SA_7)(Q36=SA_8)(Q38=SA_9)(Q40=SA_10).

string SA_1 (A2000) SA_2(A2000) SA_3(A2000) SA_4(A2000) SA_5(A2000).
compute condition = 2.
compute quiz_version = 2.
exe.

************************************M1V1.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Massed 1 Week Vers1_April 2, 2021_09.31.sav".

dataset name M1V1.

delete vars StartDate to Progress Finished to Q40.
rename variables (Q23=SA_1)(Q24=SA_2)(Q27=SA_3)(Q28=SA_4)(Q37=SA_5).

string SA_6 (A2000) SA_7(A2000) SA_8(A2000) SA_9(A2000) SA_10(A2000).
compute condition = 3.
compute quiz_version = 1.
exe.

************************************M1V2.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Massed 1 Week Vers2_April 2, 2021_09.34.sav".

dataset name M1V2.

delete vars StartDate to Progress Finished to Q37.
rename variables (Q21=SA_6)(Q29=SA_7)(Q36=SA_8)(Q38=SA_9)(Q40=SA_10).

string SA_1 (A2000) SA_2(A2000) SA_3(A2000) SA_4(A2000) SA_5(A2000).
compute condition = 3.
compute quiz_version = 2.
exe.

************************************M4V1.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Massed 4 Week Vers1_April 2, 2021_09.35.sav".

dataset name M4V1.

delete vars StartDate to Progress Finished to Q40.
rename variables (Q23=SA_1)(Q24=SA_2)(Q27=SA_3)(Q28=SA_4)(Q37=SA_5).

string SA_6 (A2000) SA_7(A2000) SA_8(A2000) SA_9(A2000) SA_10(A2000).
compute condition = 4.
compute quiz_version = 1.
exe.

************************************M4V2.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Massed 4 Week Vers2_April 2, 2021_09.35.sav".

dataset name M4V2.

delete vars StartDate to Progress Finished to Q37.
rename variables (Q21=SA_6)(Q29=SA_7)(Q36=SA_8)(Q38=SA_9)(Q40=SA_10).

string SA_1 (A2000) SA_2(A2000) SA_3(A2000) SA_4(A2000) SA_5(A2000).
compute condition = 4.
compute quiz_version = 2.
exe.

************************************Concatenating.
Add Files
/File=S1V1
/File=S1V2
/File=S4V1
/File=S4V2
/File=M1V1
/File=M1V2
/File=M4V1
/File=M4V2.
exe.

dataset name Alldata.
save outfile ="C:\Users\mikey\OneDrive\Desktop\BW Final Data\Alldata.sav".
execute.
dataset close S1V1.
dataset close S1V2.
dataset close S4V1.
dataset close S4V2.
dataset close M1V1.
dataset close M1V2.
dataset close M4V1.
dataset close M4V2.

************************************Cleaning Combined Dataset.

dataset activate Alldata.

*Condition variable is not actually used for analysis - viewing_condition and delay variables are used for analysis.

variable labels condition "Viewing condition and Test Delay".
value labels condition 1 "Spaced 1-Week Delay" 2 "Spaced 4-Week Delay" 3 "Massed 1-Week Delay" 4 "Massed 4-Week Delay".

*Deleted records with no data (61, 70, 73).

rename variables (SC0=Total_MC).

compute viewing_condition = 0.
compute delay = 0.
exe.

if condition = 1 viewing_condition = 1.
if condition = 2 viewing_condition = 1.
if condition = 3 viewing_condition = 2.
if condition = 4 viewing_condition = 2.
exe.

if condition = 1 delay = 1.
if condition = 3 delay = 1.
if condition = 2 delay = 2.
if condition = 4 delay = 2.
exe.

value labels viewing_condition 1 "Spaced" 2 "Massed".
value labels delay 1 "One-Week" 2 "Four-Week".

COMPUTE id=$CASENUM.
FORMAT id (F8.0).
exe.

rename variables 
(Q41=Prev_Watch)
(Q42=Prev_Watch2)
(Q43=Prev_Watch3)
(Q50=Gender)
(Q50_3_TEXT=GenderOther)
(Q51=Race)
(Q51_7_TEXT=RaceMulti)
(Q51_8_TEXT=RaceOther)
(Q53=Age)
(Q54=YrSchool) .
exe.

save outfile ="C:\Users\mikey\OneDrive\Desktop\BW Final Data\Alldata.sav".
execute.

save outfile = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\ReducedBWEA.sav"
    /keep = id Total_MC SA_1 to SA_5 SA_6 to SA_10 viewing_condition delay quiz_version Prev_Watch Gender to YrSchool.

save outfile = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\ShortAnswer.sav"
    /keep = id SA_1 to SA_5 SA_6 to SA_10 viewing_condition delay quiz_version.

    
************************************Adding data for Short answer scoring.
get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\ShortAnswer.sav".
exe.

dataset name SA.
compute Score_SA1 = 0.
compute Score_SA2 = 0.
compute Score_SA3 = 0.
compute Score_SA4 = 0.
compute Score_SA5 = 0.
compute Score_SA6 = 0.
compute Score_SA7 = 0.
compute Score_SA8 = 0.
compute Score_SA9 = 0.
compute Score_SA10 = 0.
exe.

*Scoring done manually here.

compute Total_SA = sum(Score_SA1, Score_SA2, Score_SA3, Score_SA4, Score_SA5, Score_SA6, Score_SA7, Score_SA8, Score_SA9, Score_SA10).
exe.

sort cases by id(A).

*Saved dataset here.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\ReducedBWEA.sav".
exe.

sort cases by id(A).
dataset name ReducedBWEA.

match files
/file=SA
/file=ReducedBWEA
/by id.
exe.

save outfile = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\BWEAout.sav"
/keep id Total_MC Total_SA viewing_condition delay quiz_version Prev_Watch Gender to YrSchool.
exe.

dataset close SA.
dataset close reducedBWEA.

***Now we have our final dataset (BWEAout) with the scored short answer questions in there.

***************************************************** PRIMARY ANALYSES *****************************************************

*Analyses consist mostly of inferential testing and assumption-checking on different data groups relevant to our hypotheses
*Analyses were repeated to exclude people who had previously watched show episodes used in this experiment


get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\BWEAout.sav".
exe.

*Creating filter for later to filter out people who already watched the show before the experiment.
*compute PrevWatch_Filter = (Prev_Watch=2).
*exe.

*To include the two people who didn't answer demographics.
*if ID = 18 or ID=19 PrevWatch_Filter = 1.
*exe.

*Checking to see if there was a difference in quiz versions. Not a sig. one but version 2 mean is about 1 point lower than v1 (this is the case whether previous watchers are included or excluded).
T-TEST GROUPS=quiz_version(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Total_MC
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

*No real diff between versions in short answer scores.
T-TEST GROUPS=quiz_version(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Total_SA
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

*Checking frequencies of each quiz version within each group. They're fairly equal.
*Largest difference is in S1 (3 more V1 than V2) when previous watchers are included.
*Largest diff is in M4 (3 more in V2 than V1) when previous watchers excluded.
crosstabs tables = viewing_condition by quiz_version by delay.


************************************PART 1: All Multiple Choice (MC) Questions.

*There's no filter here, but we decided to report results where previous watchers were excluded. So these follow ups should be done there.
**Descriptives and Normality. Violated in Massed 1-week. Case 64 is a low end outlier in M 1-week group.
EXAMINE VARIABLES=Total_MC BY viewing_condition by delay
  /PLOT BOXPLOT HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*HOV and Omnibus.
UNIANOVA Total_MC BY viewing_condition delay
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(viewing_condition*delay) TYPE=BAR ERRORBAR=CI MEANREFERENCE=NO
  /EMMEANS=TABLES(viewing_condition) COMPARE ADJ(LSD)
  /EMMEANS=TABLES(delay) COMPARE ADJ(LSD)
  /EMMEANS=TABLES(viewing_condition*delay) 
  /PRINT ETASQ HOMOGENEITY
  /CRITERIA=ALPHA(.05)
  /DESIGN=viewing_condition delay viewing_condition*delay.

*Simple comparisons as follow-up.
*First t-test compares spaced and massed at one week delay.

Temporary.
Select if delay=1.

T-TEST GROUPS=viewing_condition(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Total_MC
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

Temporary.
Select if delay=1.

*Used for Brown Forsythe HOV.
UNIANOVA Total_MC BY viewing_condition
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ HOMOGENEITY
  /CRITERIA=ALPHA(.05)
  /DESIGN=viewing_condition.

*Second t-test compares spaced and massed at four week delay.
Temporary.
Select if delay=2.

*Used for Brown Forsythe HOV.
UNIANOVA Total_MC BY viewing_condition
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ HOMOGENEITY
  /CRITERIA=ALPHA(.05)
  /DESIGN=viewing_condition.

Temporary.
Select if delay=2.

T-TEST GROUPS=viewing_condition(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Total_MC
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

************************************PART 2: All MC Excluding Previous Show Watchers.

filter by PrevWatch_filter.
exe.

**Descriptives and Normality. 2 Violations. No outliers.
EXAMINE VARIABLES=Total_MC BY viewing_condition by delay
  /PLOT BOXPLOT HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*HOV and Omnibus.
UNIANOVA Total_MC BY viewing_condition delay
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(viewing_condition*delay) TYPE=BAR ERRORBAR=CI MEANREFERENCE=NO
  /EMMEANS=TABLES(viewing_condition) COMPARE ADJ(LSD)
  /EMMEANS=TABLES(delay) COMPARE ADJ(LSD)
  /EMMEANS=TABLES(viewing_condition*delay)
  /PRINT ETASQ HOMOGENEITY opower
  /CRITERIA=ALPHA(.05)
  /DESIGN=viewing_condition delay viewing_condition*delay.

Temporary.
Select if delay=1.

T-TEST GROUPS=viewing_condition(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Total_MC
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

Temporary.
Select if delay=1.

*Used for Brown Forsythe HOV.
UNIANOVA Total_MC BY viewing_condition
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ HOMOGENEITY opower
  /CRITERIA=ALPHA(.05)
  /DESIGN=viewing_condition.

*Second t-test compares spaced and massed at four week delay.
Temporary.
Select if delay=2.

*Used for Brown Forsythe HOV.
UNIANOVA Total_MC BY viewing_condition
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ HOMOGENEITY opower
  /CRITERIA=ALPHA(.05)
  /DESIGN=viewing_condition.

Temporary.
Select if delay=2.

T-TEST GROUPS=viewing_condition(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Total_MC
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

filter off.

************************************PART 3: Recurring MC Questions only.

*Descriptives and Normality.
EXAMINE VARIABLES=Total_RE BY viewing_condition by delay
  /PLOT BOXPLOT HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*HOV and Omnibus.
UNIANOVA Total_RE BY viewing_condition delay
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(viewing_condition*delay) TYPE=BAR ERRORBAR=CI MEANREFERENCE=NO
  /EMMEANS=TABLES(viewing_condition) COMPARE ADJ(LSD)
  /EMMEANS=TABLES(delay) COMPARE ADJ(LSD)
  /EMMEANS=TABLES(viewing_condition*delay) 
  /PRINT ETASQ HOMOGENEITY
  /CRITERIA=ALPHA(.05)
  /DESIGN=viewing_condition delay viewing_condition*delay.


************************************PART 4: Recurring MC Questions Excluding Previous Watchers.

filter by PrevWatch_filter.
exe.

*Descriptives and Normality.
EXAMINE VARIABLES=Total_RE BY viewing_condition by delay
  /PLOT BOXPLOT HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*HOV and Omnibus.
UNIANOVA Total_RE BY viewing_condition delay
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(viewing_condition*delay) TYPE=BAR ERRORBAR=CI MEANREFERENCE=NO
  /EMMEANS=TABLES(viewing_condition) COMPARE ADJ(LSD)
  /EMMEANS=TABLES(delay) COMPARE ADJ(LSD)
  /EMMEANS=TABLES(viewing_condition*delay) 
  /PRINT ETASQ HOMOGENEITY
  /CRITERIA=ALPHA(.05)
  /DESIGN=viewing_condition delay viewing_condition*delay.

filter off.

************************************PART 5: Short Answer (SA) Questions.

*Descriptives and Normality.
EXAMINE VARIABLES=Total_SA BY viewing_condition by delay
  /PLOT BOXPLOT HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*HOV and Omnibus.
UNIANOVA Total_SA BY viewing_condition delay
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(viewing_condition*delay) TYPE=BAR ERRORBAR=CI MEANREFERENCE=NO
  /EMMEANS=TABLES(viewing_condition) COMPARE ADJ(LSD)
  /EMMEANS=TABLES(delay) COMPARE ADJ(LSD)
  /EMMEANS=TABLES(viewing_condition*delay) 
  /PRINT ETASQ HOMOGENEITY
  /CRITERIA=ALPHA(.05)
  /DESIGN=viewing_condition delay viewing_condition*delay.

************************************PART 6: SA Questions Excluding Previous Watchers.
filter by PrevWatch_filter.
exe.

*Descriptives and Normality.
EXAMINE VARIABLES=Total_SA BY viewing_condition by delay
  /PLOT BOXPLOT HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*HOV and Omnibus.
UNIANOVA Total_SA BY viewing_condition delay
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(viewing_condition*delay) TYPE=BAR ERRORBAR=CI MEANREFERENCE=NO
  /EMMEANS=TABLES(viewing_condition) COMPARE ADJ(LSD)
  /EMMEANS=TABLES(delay) COMPARE ADJ(LSD)
  /EMMEANS=TABLES(viewing_condition*delay) 
  /PRINT ETASQ HOMOGENEITY
  /CRITERIA=ALPHA(.05)
  /DESIGN=viewing_condition delay viewing_condition*delay.

filter off.

************************************Ep 3 Questions only.

filter by PrevWatch_filter.
exe.

*Descriptives and Normality.
EXAMINE VARIABLES=Total_Ep3 BY viewing_condition by delay
  /PLOT BOXPLOT HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*HOV and Omnibus.
UNIANOVA Total_Ep3 BY viewing_condition delay
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(viewing_condition*delay) TYPE=BAR ERRORBAR=CI MEANREFERENCE=NO
  /EMMEANS=TABLES(viewing_condition) COMPARE ADJ(LSD)
  /EMMEANS=TABLES(delay) COMPARE ADJ(LSD)
  /EMMEANS=TABLES(viewing_condition*delay) 
  /PRINT ETASQ HOMOGENEITY
  /CRITERIA=ALPHA(.05)
  /DESIGN=viewing_condition delay viewing_condition*delay.

Temporary.
Select if delay=1.

*Used for Brown Forsythe HOV.
UNIANOVA Total_Ep3 BY viewing_condition
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ HOMOGENEITY opower
  /CRITERIA=ALPHA(.05)
  /DESIGN=viewing_condition.

Temporary.
Select if delay=1.

T-TEST GROUPS=viewing_condition(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Total_Ep3
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

*Second t-test compares spaced and massed at four week delay.
Temporary.
Select if delay=2.

*Used for Brown Forsythe HOV.
UNIANOVA Total_Ep3 BY viewing_condition
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ HOMOGENEITY opower
  /CRITERIA=ALPHA(.05)
  /DESIGN=viewing_condition.

Temporary.
Select if delay=2.

T-TEST GROUPS=viewing_condition(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Total_Ep3
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

filter off.


************************************ END OF PRIMARY INFERENTIAL ANALYSIS ************************************

filter by PrevWatch_filter.
exe.

*Getting useful tables for each DV.
means tables = total_MC by viewing_condition by delay
    /cells = count mean stddev skew kurt.
exe.

means tables = total_RE by viewing_condition by delay
    /cells = count mean stddev skew kurt.
exe.

means tables = total_SA by viewing_condition by delay
    /cells = count mean stddev skew kurt.
exe.

means tables = total_ep3 by viewing_condition by delay
    /cells = count mean stddev skew kurt.
exe.

filter off.
************************************************************************************************************.

*Demographics.
filter by PrevWatch_filter.
exe.

FREQUENCIES VARIABLES=Gender GenderOther Race RaceMulti RaceOther YrSchool
  /ORDER=ANALYSIS.

*compute NewAge = Age + 17.
*exe.

FREQUENCIES VARIABLES=NewAge
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

filter off.
********************************************************************************************************************************.

*Now getting information about previous watchers.
get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\Alldata2.sav".
exe.

FREQUENCIES VARIABLES=Q41 Q42 Q43
  /BARCHART FREQ
  /ORDER=ANALYSIS.
OUTPUT MODIFY
  /REPORT PRINTREPORT=NO
  /SELECT TABLES
  /IF COMMANDS=["Frequencies(LAST)"] SUBTYPES="Frequencies"
  /TABLECELLS SELECT=[VALIDPERCENT] APPLYTO=COLUMN HIDE=YES
  /TABLECELLS SELECT=[CUMULATIVEPERCENT] APPLYTO=COLUMN HIDE=YES
  /TABLECELLS SELECT=[TOTAL] SELECTCONDITION=PARENT(VALID) APPLYTO=ROW HIDE=YES
  /TABLECELLS SELECT=[TOTAL] SELECTCONDITION=PARENT(MISSING) APPLYTO=ROW HIDE=YES
  /TABLECELLS SELECT=[VALID] APPLYTO=ROWHEADER UNGROUP=YES
  /TABLECELLS SELECT=[PERCENT] SELECTDIMENSION=COLUMNS FORMAT="PCT" APPLYTO=COLUMN
  /TABLECELLS SELECT=[COUNT] APPLYTO=COLUMNHEADER REPLACE="N"
  /TABLECELLS SELECT=[PERCENT] APPLYTO=COLUMNHEADER REPLACE="%".




