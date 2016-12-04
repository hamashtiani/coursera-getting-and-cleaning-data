# coursera-getting-and-cleaning-data

This read me contains the description for the code written in the run_analysis.R file:

1. The code begins by downloading the raw data  

2. Each dataset is read into R by getting assigned to a dataset object

3. Next, the code looks at the features.txt file which includes all the measurements to extract only the mean and the standard deviation measurements

4. Then, the values in the activity variable are replaced by string variables to give the user a clearer understanding of what each activity indicates

5. Finally, a new data set, “newSet”, is created by taking the mean of each variable by both ID and activity and its written to the computer by the name of “meandata.txt”
