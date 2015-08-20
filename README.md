# Getting Data Project

This directory contains:
- This readme file
- run_analysis.R - R script that performs the analysis of the supplied data
- final_data.txt - results of the run_analysis.R script
- codebook.md - This explains the results output 

The Run Analysis R script performs the following tasks:

-Merges the train and test data
-Filters out all of the unrequired columns (keeping only the mean and standard deviation observations)
-Renames the activities to be easily readable in the dataset
-Names the variables using the supplied codebook
-Reshapes the data and aggregates it to obtain the mean values of all the observations for: Activity, Subject and Variable.