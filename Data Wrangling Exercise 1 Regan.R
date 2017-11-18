install.packages("tidyverse")
library(tidyverse)
library(stringr)
library(dbplyr)
library(readxl)
library(stringr)

raw_data <- read_excel("refine.xlsx")

# clean company name
clean_raw_data <- raw_data %>%
mutate(lower_company = tolower(company),
       first_letter = substr(lower_company, 0, 1), 
       clean_company = ifelse(first_letter == "p", "phillips", 
                              ifelse(first_letter == "a", "akzo",
                                     ifelse(first_letter == "v", "van houten",
                                            ifelse(first_letter == "f", "phillips", 
                                             ifelse(first_letter == "u", "unliever", first_letter))))) 


# split up product code and number       
clean_raw_data <- clean_raw_data %>%
  
 separate(col = "Product code / number",into = c("product_code","product_number"),sep="-")

#add product category
clean_raw_data <- clean_raw_data %>%
  mutate(product_category = ifelse(product_code == 'p', "Smartphone",
                                   ifelse(product_code == 'v', "TV",
                                          ifelse(product_code == 'x', "Laptop",
                                                 ifelse(product_code == 'q', "Tablet", product_code)))))

# create full address
clean_raw_data <- clean_raw_data %>%
  mutate(full_address = paste(address, city, country, sep = ","))

#binary
clean_raw_data <- clean_raw_data %>%
 mutate(company_phillips = ifelse(clean_company == "phillips", 1, 0))
 
clean_raw_data <- clean_raw_data %>%
  mutate(company_akzo = ifelse(clean_company == "akzo", 1, 0))

clean_raw_data <- clean_raw_data %>%
  mutate(company_van_houten = ifelse(clean_company == "van houten", 1, 0))

clean_raw_data <- clean_raw_data %>%
  mutate(company_unilever = ifelse(clean_company == "unilever", 1, 0))

# product_smartphone, product_tv, product_laptop and product_tablet binaries

clean_raw_data <- clean_raw_data %>%
  mutate(product_smartphone = ifelse(product_category == "Smartphone", 1, 0))

clean_raw_data <- clean_raw_data %>%
  mutate(product_tv = ifelse(product_category == "TV", 1, 0))

clean_raw_data <- clean_raw_data %>%
  mutate(product_laptop = ifelse(product_category == "Laptop", 1, 0))

clean_raw_data <- clean_raw_data %>%
  mutate(product_tablet = ifelse(product_category == "Tablet", 1, 0))


write.csv(clean_raw_data, "refine_clean.csv")
write.csv(raw_date, "refine_original.csv")

