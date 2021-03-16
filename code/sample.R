#
# This code is converted from do file by transtataR 0.0.1.
#

# Loading Packages ---------------------------------

library(readr)
library(stringr)
library(dplyr)
library(broom)

# insheet using 'data/titanic passenger list.csv' ---------------------------------

dat <- read_csv("data/titanic passenger list.csv")
names(dat) <- str_replace_all(names(dat), " +", "_")

# list age sex if age > 20 ---------------------------------

temp <- dat
temp <- select(temp, age, sex)
temp <- filter(temp, age > 20)
head(temp)

# reg survived c.sex age ---------------------------------

model <- lm(survived ~ as.factor(sex) + age, data = dat)
tidy(model, conf.int = TRUE)
glance(model)

# End of file
