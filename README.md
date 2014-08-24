---
title: "README for Getting and Cleaning Data course project"
author: "R Sirmons"
date: "Sunday, August 24, 2014"
output: html_document
---

--Data transforms to create XYtidy.txt dataset in run_analysis.R

After reading all data the test data is processed first.  First the activity labels are merged with the Y_test data. Next the features data are applied to the X_test data as the 561 variable names and friendly names (ActivityId,  ActivityName, SubjectId) are applied to the subject data and the activity data.  Finally the test data, the subject data and the activity data are combined into one data frame.  This processing is then repeated for the training data.

Next the test and training data frames are combined into one data frame.  That combined data frame is then filtered to only columns with "mean" or "std" in their names (plus ActivityId,  ActivityName, and SubjectId).  Then this data frame is aggregated by SubjectId and ActivityId and an average calculated for each data field for each aggregation.  The columns are then renamed to prefix all 'mean' or 'std' columns with "Average of_" to differentiate them from other variables in the original dataset.  The activity labels are then merged with the data frame and the ActivityId,  ActivityName, and SubjectId column names reapplied.  Finally the ActivityName column is moved to place it next to the ActivityId column and the data frame written to the disk as XYtidy.txt using row.names =FALSE.
