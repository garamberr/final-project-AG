# //  EPI 590R FINAL PROJECT //
# Name: Amber-Leigh Garcia

install.packages("medicaldata")
library(medicaldata)
library(tidyr)

data(package = "medicaldata")

# This data set contains data concerning testing for SARS-CoV2 via PCR as well as associated metadata.
# The data has been anonymized, time-shifted, and permuted.
covid_dataset <- medicaldata::covid_testing

library(gtsummary)

# CREATE A {GTSUMMARY}
tbl_summary(
	covid_dataset,
	by = gender,
	include = c(ct_result, result, clinic_name, age),

	label = list(
		ct_result ~ "Cycle Number",
		result ~ "Result",
		clinic_name ~ "Clinic Name",
		age ~ "Age"
	)
)

# Dropping Invalid Test Results
covid_dataset <- covid_dataset %>%
	mutate(result = ifelse(result == "positive", 1,
												 ifelse(result == "negative", 0, NA)))

covid_dataset <- covid_dataset %>%
	drop_na(result)

covid_dataset$result <- as.numeric(covid_dataset$result)

# FIT A UNIVARIATE REGRESSON
Univariate_Analysis <- tbl_uvregression(
	covid_dataset,
	y = result,
	include = c(gender, age),
	method = glm,
	exponentiate = TRUE
)

covid_dataset2 <- covid_dataset %>%
	drop_na()

# CREATE A FIGURE
hist(covid_dataset$result)

# WRITE AND USE A FUNCTION THAT DOES SOMETHING WTH THE DATA
covid_mean <- function(x) {

n <- length(x)
mean_val <- sum(x) / n

return(mean_val)
}
covid_mean(covid_dataset2$orderset)

# DOWNLOAD AND RENDER QUARTO DOCUMENT

# {HERE} PACKAGE
install.packages("here")
here::here("data", "raw", "data.csv")

# {RENV} PACKAGE
install.packages("renv")
renv::init()
