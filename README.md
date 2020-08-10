# Tidy-data-for-human-recognition-using-smartphones
A full description of the data used is given here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

<h2>Instructions</h2>
In order for the script run_analysis.R to work, please follow these instructions.

1. Download the data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Unzip the data in the **folder that is going to be used as your working directory**. The unzipped folder must have as name **UCI HAR Dataset**.

3. Open RStudio.

4. Set your working directory using *setwd()*, check again that the folder **UCI HAR Dataset** is inside the folder used as working directory and not inside another folder within the former.

5. Check that you have the **dplyr** package installed, you can do so by running in the console *library(dplyr)*, an alert message will appear if you don’t have the package installed. In that case install it using *install_packages(dplyr)*

6. Run the script *run_analysis.R*

7. Check your working directory, a file called **tidyDataSet.txt** should be there.

<h2>How run_analysis.R works</h2>
The script will import the following files into R as data frames

* activity_labels.txt
* y_train.txt
* y_test.txt
* features.txt
* subject_train.txt
* subject_test.txt
* X_train.txt
* X_test.txt

Then the script will create a tidy data set that consist of 69 variables and 10299 observations, from this tidy data set, a second independent tidy data set will be created, this one consists of 68 variables and 180 observations. 
