# Data-mining-the-water-table
We have taken the data from Driven Data ‘Pump it up: Data Mining the Water Table’ challenge where we have to predict status_group which is functional, non-functional and functional needs repair. The dataset has features such as the location of the pump, water quality, source type, extraction technique used, and population demographics of pump location. The training set has 59,401 rows and 40 features including an output column.  Out of the 40 features in the data, we have 31 categorical variables, 7 numerical variables, and 2 date variables.  
Steps to run the Project:

1. Place the given train_data, test_data in the working data.
2. select all the code of clean_data.R and run it (pre processing of data).
3. After running the clean_data file , run the project file.
4. Confusion matrices of all models are printed.

Package Used:

Rpart
E1071
ipred
Ada
Adabag
gbm
class
