* Encoding: UTF-8.

*For Short answer scoring.
get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\BWEAoutfin2.sav".
exe.

*Creating filter for later.
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


********************************************************************************************************************************PART 1: All Multiple Choice (MC) Questions.

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

********************************************************************************************************************************PART 2: All MC Excluding Previous HoC Watchers.

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

********************************************************************************************************************************PART 3: Recurring MC Questions only.

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


********************************************************************************************************************************PART 4: Recurring MC Questions Excluding Previous Watchers.

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

********************************************************************************************************************************PART 5: Short Answer (SA) Questions.

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

********************************************************************************************************************************PART 6: SA Questions Excluding Previous Watchers.
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

********************************************************************************************************************************Ep 3 Questions only.

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


********************************************************************************************************************************.

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
********************************************************************************************************************************.

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




