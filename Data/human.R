#Francesco Durante, 21.11.2019, Assignment 4.1 Data wrangling.

#4.1.2.Reading the datasets "human development" and "gender inequality index":

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#4.1.3.Exploration of the structure and dimension of the data, summary of the variables.
str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

#4.1.4 Rename of the hd columns
#Human development index Rank becomes HDIRk.
colnames(hd) [1] <- "HDIRk"
#Country stays Country.
colnames(hd) [2] <- "Country"
#Human development index becomes HDI.
colnames(hd) [3] <- "HDI"
#Life expectancy at birth becomes Life.Exp.
colnames(hd) [4] <- "Life.Exp"
#Expected years of education becomes Edu.Exp.
colnames(hd) [5] <- "Edu.Exp"
#Mean years of Education becomes MeYEdu.
colnames(hd) [6] <- "MeYEdu"
#Gross National Index per Capita becomes GNI.
colnames(hd) [7] <- "GNI"
#Rank of Gross National Index per capita minus Human Development index rank becomes GNIn-HDIn.
colnames(hd) [8] <- "GNIn-HDIn"
colnames(hd)

#Rename of the gii columns
#Gender Inequality Index Rank becomes GIIRk.
colnames(gii) [1] <- "GIIRk"
#Country stayss Country.
colnames(gii) [2] <- "Country"
#Gender Inequality Index becomes GII.
colnames(gii) [3] <- "GII"
#Maternal Mortality Rate becomes MMR.
colnames(gii) [4] <- "MMR"
#Adolescent Birth Rate becomes Ado.Birth.
colnames(gii) [5] <- "Ado.Birth"
#Percentage of Representation in Parliament becomes Parli.F.
colnames(gii) [6] <- "Parli.F"
#Population with secondary education female becomes Edu2.F
colnames(gii) [7] <- "Edu2.F"
#Population with secondary education male becomes Edu2.M
colnames(gii) [8] <- "Edu2.M"
#Labour force participation rate Female becomes Labo2.F
colnames(gii) [9] <- "Labo2.F"
#Labour force participation rate Male becomes Labo2.M
colnames(gii) [10] <- "Labo2.M"

colnames(gii)

#4.1.5 Mutate Gender Inequality data and create two new variables.   
library(dplyr); library(ggplot2)

#First new variable: Female and Male ratio of populations with secondary education in each country. (edu2F/edu2M).
gii <- mutate(gii, edu2.FM = (Edu2.F/Edu2.M))



#Second new variable: Female and Male ratio of labour force participation in each country (i.e. labF / labM).
gii <- mutate(gii, Labo.FM = (Labo2.F/Labo2.M))

#joining the two datasets
library(dplyr)
join_by <- "Country"
human <- inner_join(hd, gii, join_by)

#Watching the new joined database.
colnames(human)
glimpse(human)


#Saving the new database.
write.csv(human, file = "human.csv")

write.table(human, file = "human.txt", sep = "\t", row.names = TRUE, col.names = NA)


read.csv("human.csv")
