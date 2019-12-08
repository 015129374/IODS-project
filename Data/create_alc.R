Francesco Durante, 13.11.2019. Creation of a new dataset from [a previous dataset] (https://archive.ics.uci.edu/ml/datasets/Student+Performance)

#1.3.Reading of student-mat and -por files, and exploration of data dimensions and structure

math <- read.csv("Data/student-mat.csv", sep = ";", header = TRUE)
por <- read.csv("Data/student-por.csv", sep = ";", header = TRUE)

str(math)
dim(math)

str(por)
dim(por)

colnames(math)
colnames(por)

#1.4.Join the two data sets using the prescribed variables.
install.packages("dplyr")
library(dplyr)

join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet")

math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))


#Joined data's structure and dimension exploration. 
colnames(math_por)

dim(math_por)
str(math_por)

#1.5. Combining the duplicated answer of the joined data with the if-else structure.
alc <- select(math_por, one_of(join_by))

notjoined_columns <- colnames(math)[!colnames(math)%in% join_by]

notjoined_columns

for(column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  if(is.numeric(first_column)){
    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- first_column
  }
}

glimpse(alc)

#1.6 Creation of new column alc_use and of logical column high_use.
library(dplyr) ; library(ggplot2)

#Creation of the new column alc_use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)
dim(alc)

#1.7 Saving the dataset as .csv and .txt
write.csv(alc, file = "alc.csv")

write.table(alc, file = "alc.txt", sep = "\t", row.names = TRUE, col.names = NA)
read.csv("alc.csv")
