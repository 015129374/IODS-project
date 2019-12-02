#Francesco Durante, 21.11.2019, Assignment 4.1 Data wrangling.
#Francesco Durante, 27.11.2019, Assignment 5.1 Data wrangling.

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
gii <- mutate(gii, Edu2.FM = (Edu2.F/Edu2.M))


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

#5.1. Reading the data file [As using my file from the past week gave a wrong dimension I use the link.]
human5.1 <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep = ",", header = TRUE)

#The dataset comes from the United Nations Development Programme, and it is used to calculate the human development index.
# It has a dimension of 195 observations for 9 variables and it includes the following columns and dimensions.
names(human5.1)
str(human5.1)
dim(human5.1)
summary(human5.1)



#5.1.1. Transforming GNI to numeric variable.
library(stringr)
str(human5.1$GNI)
str_replace(human5.1$GNI, pattern=",", replace ="") %>% as.numeric

#5.1.2. Exluding unneded variables.
library(dplyr)
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human5.1 <- select(human5.1, one_of(keep))

#5.1.3. Removing all rows with missing values.
complete.cases(human5.1)
data.frame(human5.1[-1], comp = complete.cases(human5.1))
human_ <- filter(human5.1, complete.cases(human5.1))

#5.1.4. Removing regional observations.
tail(human5.1, 10)
last <- nrow(human5.1) - 7
human_ <- human5.1[1:last, ]

dim(human_)

#save data
write.table(human_, file = "human_.csv", sep = ",", row.names = TRUE, col.names = NA)

read.csv("human_.csv")
