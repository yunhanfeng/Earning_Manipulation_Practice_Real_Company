
# Operating cash flow predict model

setwd("C:\\Users\\fengy\\Desktop\\Summer\\2. Financial Accting\\Final")
df1 = read.csv('amgen_compustate.csv')

library(magrittr)
library(dplyr)

## Amgen: Predictive power of operating cash flow 
df1$accurals = df1$ni - df1$oancf

df01 <- df1[,c('gvkey','fyear','oancf')]
df02 <- mutate(df01, fyear = fyear - 1) %>%
  rename(., next_oancf = oancf)
df1 <- left_join(df1, df02, by = c('gvkey',"fyear"))

oc_reg <- lm(df1$next_oancf ~ df1$accurals + df1$oancf)
summary(oc_reg)

# run the model every five year
y1992 <- df1[df1['fyear'] <= '1992',]
oc_reg_92 <- lm(y1992$next_oancf ~ y1992$accurals + y1992$oancf)
summary(oc_reg_92)

y1997 <- df1[df1['fyear'] > '1992' & df1['fyear'] <= '1997',]
oc_reg_97 <- lm(y1997$next_oancf ~ y1997$accurals + y1997$oancf)
summary(oc_reg_97)

y02 <- df1[df1['fyear'] > '1997' & df1['fyear'] <= '2002',]
oc_reg_02 <- lm(y02$next_oancf ~ y02$accurals + y02$oancf)
summary(oc_reg_02)

y07 <- df1[df1['fyear'] > '2002' & df1['fyear'] <= '2007',]
oc_reg_07 <- lm(y07$next_oancf ~ y07$accurals + y07$oancf)
summary(oc_reg_07)

y12 <- df1[df1['fyear'] > '2007' & df1['fyear'] <= '2012',]
oc_reg_12 <- lm(y12$next_oancf ~ y12$accurals + y12$oancf)
summary(oc_reg_12)
S
y16 <- df1[df1['fyear'] > '2007' & df1['fyear'] <= '2016',]
oc_reg_16 <- lm(y16$next_oancf ~ y16$accurals + y16$oancf)
summary(oc_reg_16)

require(broom)
a <- tidy(oc_reg_16)
