# //  EPI 590R FINAL PROJECT //
# Name: Amber-Leigh Garcia

install.packages("medicaldata")
library(medicaldata)

data(package = "medicaldata")

#This data set contains data concerning testing for SARS-CoV2 via PCR as well as associated metadata.
#The data has been anonymized, time-shifted, and permuted.
covid_dataset <- medicaldata::covid_testing

library(gtsummary)

#Descriptive Table
tbl_summary(
	covid_dataset,
	by = gender,
	include = c(ct_result, result, payor_group, clinic_name)
)

#Regression Table
tbl_uvregression(
	covid_dataset,
	y = ct_result,
	include = c(gender, payor_group, clinic_name, result),
	method = lm
)
