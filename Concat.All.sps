* Encoding: UTF-8.

***********************************************************S1V1.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Spaced 1 Week Vers1_April 2, 2021_09.37.sav".
exe.

dataset name S1V1.

delete vars StartDate to Progress Finished to Q40.
rename variables (Q23=SA_1)(Q24=SA_2)(Q27=SA_3)(Q28=SA_4)(Q37=SA_5).

string SA_6 (A2000) SA_7(A2000) SA_8(A2000) SA_9(A2000) SA_10(A2000).
compute condition = 1.
compute quiz_version = 1.
exe.

***********************************************************S1V2.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Spaced 1 Week Vers2_April 2, 2021_09.38.sav".
exe.

dataset name S1V2.

delete vars StartDate to Progress Finished to Q37.
rename variables (Q21=SA_6)(Q29=SA_7)(Q36=SA_8)(Q38=SA_9)(Q40=SA_10).

string SA_1 (A2000) SA_2(A2000) SA_3(A2000) SA_4(A2000) SA_5(A2000).
compute condition = 1.
compute quiz_version = 2.
exe.


***********************************************************S4V1.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Spaced 4 Week Vers1_April 2, 2021_09.36.sav".

dataset name S4V1.

delete vars StartDate to Progress Finished to Q40.
rename variables (Q23=SA_1)(Q24=SA_2)(Q27=SA_3)(Q28=SA_4)(Q37=SA_5).

string SA_6 (A2000) SA_7(A2000) SA_8(A2000) SA_9(A2000) SA_10(A2000).
compute condition = 2.
compute quiz_version = 1.
exe.

***********************************************************S4V2.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Spaced 4 Week Vers2_April 2, 2021_09.37.sav".

dataset name S4V2.

delete vars StartDate to Progress Finished to Q37.
rename variables (Q21=SA_6)(Q29=SA_7)(Q36=SA_8)(Q38=SA_9)(Q40=SA_10).

string SA_1 (A2000) SA_2(A2000) SA_3(A2000) SA_4(A2000) SA_5(A2000).
compute condition = 2.
compute quiz_version = 2.
exe.

***********************************************************M1V1.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Massed 1 Week Vers1_April 2, 2021_09.31.sav".

dataset name M1V1.

delete vars StartDate to Progress Finished to Q40.
rename variables (Q23=SA_1)(Q24=SA_2)(Q27=SA_3)(Q28=SA_4)(Q37=SA_5).

string SA_6 (A2000) SA_7(A2000) SA_8(A2000) SA_9(A2000) SA_10(A2000).
compute condition = 3.
compute quiz_version = 1.
exe.

***********************************************************M1V2.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Massed 1 Week Vers2_April 2, 2021_09.34.sav".

dataset name M1V2.

delete vars StartDate to Progress Finished to Q37.
rename variables (Q21=SA_6)(Q29=SA_7)(Q36=SA_8)(Q38=SA_9)(Q40=SA_10).

string SA_1 (A2000) SA_2(A2000) SA_3(A2000) SA_4(A2000) SA_5(A2000).
compute condition = 3.
compute quiz_version = 2.
exe.

***********************************************************M4V1.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Massed 4 Week Vers1_April 2, 2021_09.35.sav".

dataset name M4V1.

delete vars StartDate to Progress Finished to Q40.
rename variables (Q23=SA_1)(Q24=SA_2)(Q27=SA_3)(Q28=SA_4)(Q37=SA_5).

string SA_6 (A2000) SA_7(A2000) SA_8(A2000) SA_9(A2000) SA_10(A2000).
compute condition = 4.
compute quiz_version = 1.
exe.

***********************************************************M4V2.

get file = "C:\Users\mikey\OneDrive\Desktop\BW Final Data\HoC Massed 4 Week Vers2_April 2, 2021_09.35.sav".

dataset name M4V2.

delete vars StartDate to Progress Finished to Q37.
rename variables (Q21=SA_6)(Q29=SA_7)(Q36=SA_8)(Q38=SA_9)(Q40=SA_10).

string SA_1 (A2000) SA_2(A2000) SA_3(A2000) SA_4(A2000) SA_5(A2000).
compute condition = 4.
compute quiz_version = 2.
exe.

***********************************************************Concatenating.
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

***********************************************************Cleaning Combined Dataset.

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

*For Short answer scoring.
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
