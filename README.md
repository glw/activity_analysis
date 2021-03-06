# activity_analysis

Created by Garret Wais for Cousera class "Getting and Cleaning Data". 

R version 3.1.0 (2014-04-10)

Date created 4/16/2014

## Project Description:

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

1. You should create one R script called run_analysis.R that does the following. 
2. Merges the training and the test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive variable names. 
6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## To run analysis:

### Set working directory in run_analysis.R to your users working directory.

### Make sure both run_analysis.R, and run_analysis.Rmd are in the same folder.
      
     **run_analysis.R** calls **run_analysis.Rmd** and dynamically creates a new **CodeBook.md**

1. Required R packages:
 * knitr
 * markdown

  Can be installed using `install.packages()` command.

2. Download repo in commmand line using: `git clone https://github.com/glw/activity_analysis.git`

3. From within cloned directory run `run_analysis.R`, this will:
 * Download datafile zip from the source
 * run the analysis
 * and create CodeBook.md

+ To run from R or Rstudio on windows, mac, linux...

     * Open R or Rstudio and set your working directory 
     
       `setwd("your\path\to\cloned\directory")`
     
       `source("run_analysis.Rmd")`

+ To run from linux commandline...

       `cd your\path\to\cloned\directory`
     
       `R CMD BATCH run_analysis.Rmd`

## Output of run_analysis.Rmd:

* activity_analysis_tidy_dataset.txt (tab delimited text)
* CodeBook.md **(I have inlcuded my CodeBook.md output within the repo for convenience and as required by course instructions.)**