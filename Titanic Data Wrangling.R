install.packages("tidyverse")

library(tidyverse)
library(dbplyr)
library(readxl)

raw_data <- read_excel("titanic3.xls")


## str(raw_data)

## Replace blanks with 'S' in embarked column

ind <- which(is.na(raw_data$embarked))
print(ind)

raw_data$embarked[ind] <- "S"

# Calculate mean age 
mean_age <- mean(raw_data$age, na.rm = TRUE)

# Try another way of calculating a representative age

median_age <- median(raw_data$age, na.rm = TRUE)

# Replace blank age with the mean

ind_age <- which(is.na(raw_data$age))

raw_data$age[ind_age] <- mean_age

# Could have used the median to populate the age because the age was likely skewed younger, or I could have trimmed the mean in order to get rid of edge cases

# Insert 'None' for passengers that did not have a boat

raw_data$boat[is.na(raw_data$boat)] <- "None"

# Create column has_cabin_number and enter 1 if the passnger had a cabin and 0 if the passenger did not

raw_data$has_cabin_number <- ifelse(is.na(raw_data$cabin), 0,1)

# write to new csv file

write.csv(raw_data, file = "titanic_clean.csv")
