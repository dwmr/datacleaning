Getting and Cleaning Data: Course Project
=========================================

This repository contains a data processing script (run_analysis.R) along with a sample of its output (tidy_data.csv), a code book for the output data set (CodeBook.md), and this Readme file (README.md).

The procesing routine requires the 'plyr' and 'data.table' packages and will attempt to install (and subsequently load) them if they are not already installed.  Warnings are not supressed.

In general, the script:

1. Loads (and installs if necessary) required packages.
2. Downloads an archive containing the data to be processed.
3. Loads and subsets the test set data to the specified variables.
4. Loads and subsets the training set data to the specified variables.
5. Concatenate the test and training sets.
6. Calculates mean values for each varaible on each distinct combination of subject and activity in the merged set.
7. Writes the summarized set to a csv (tidy_data.csv).

Data definitions are provided in the code book (CodeBook.md).