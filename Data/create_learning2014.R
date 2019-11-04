#Francesco Durante, 04.11.2019, new script for the data wrangling exercise (task 1-4, 2nd Assignment).
#DATA SOURCE: http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt


#(task 2) Reading the full learning2014 data
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header = TRUE)

#(task 2) Looking at the structure of the data
str(learning2014)

#(task 2) Looking at the dimension of the data
dim(learning2014)

#(task 2)DATASET DESCRIPTION: The dataset comprises 183 objects of 60 variables.

#(task 3) SCALING VARIABLES
#Divide each number in a vector & scaling "attitude".
c(1, 2, 3, 4, 5) / 2
learning2014$Attitude
learning2014$Attitude/10
learning2014$Attitude <- learning2014$Attitude/10

#(task 3) CREATION OF AN ANALYSIS DATASET.
  #Install and access 'dplyr'
install.packages("dplyr")
library(dplyr)
  
 #GROUPING QUESTIONS AND COLUMNS' FORMATION
  #Question groups for "deep", "strategic" and "surface" learning.
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")

  #Selection of the columns related to deep learning and creation of the column 'deep' by averaging
deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

  #Selection of the columns related to strategic learning and creation of the column 'stra' by averaging
strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(strategic_columns)

  #Selection of the columns related to surface learning and creation of the column 'surf' by averaging
surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

  #(task 3) Choosing columns for the new dataset.
library(dplyr)
keep_columns <- c("gender", "Age", "Attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(learning2014, one_of(keep_columns))

#(task 3) Exclude observation where the exam point variable is zero
library(dplyr)
learning2014 <- filter(learning2014, Points > 0)
dim(learning2014)


#Save file in .csv and .txt
write.csv(learning2014, file="learning2014.csv")
write.table(learning2014, file = "learning2014.txt", sep = "\t",
            row.names = TRUE, col.names = NA)

#Readings "learning2014.csv"
read.csv("learning2014.csv")
str("learning2014.csv")
head("learning.csv")

#Readings "learning2014.txt"
read.table("learning2014.txt")
str("learning2014.txt")
head("learning2014.txt")
