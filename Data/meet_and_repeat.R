#Francesco Durante 04.12.2019, 6.1. Data analysis, Assignment 6.
#Original data sources: BPRS(https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt),
#                       RATS(https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt).


#6.1.1.Loading of the datasets BPRS and RATS, variable names, contents, structures and summaries.
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = TRUE)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep ="\t", header = TRUE)

names(BPRS)
names(RATS)

str(BPRS)
str(RATS)

summary(BPRS)
summary(RATS)

#6.1.2.Conversion of BRPS and RATS categorical variables in factors.
library(dplyr); library(tidyr)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#6.1.3.Conversion of BRPS and RATS to long form. Addition of week variable to BPRS and Time varibale to RATS.
BPRSL <- gather(BPRS, key = weeks, value = bprs, -treatment, -subject) %>% mutate(week = as.integer(substr(weeks, 5,5)))

RATSL <- gather(RATS, key = WD, value = Weight, -ID, - Group) %>% mutate(Time = as.integer(substr(WD,3,4)))

#6.1.4.A look to the new datasets: variables name, contents and structures, summaries, and comparison with the wide versions.
glimpse(BPRSL)
str(BPRSL)
summary(BPRSL)

glimpse(RATSL)
str(RATSL)

summary(RATSL)

#The advantage of the long form data are: 1)it better summarize a dataset with many value variable.
#2) It facilitates conceptual clarity by structuring data as key-value pairs.
#3) The long-form datasets are required for advanced statistical analysis and graphing, as many of them
#rely on long-form data.
#[Reference](https://sejdemyr.github.io/r-tutorials/basics/wide-and-long/)

write.table(RATSL, file = "RATSL.csv", sep = ",", row.names = TRUE, col.names = NA)
write.table(BPRSL, file = "BPRSL.csv", sep = ",", row.names = TRUE, col.names = NA)
read.csv("RATSL.csv")
read.csv("BPRSL.csv")
