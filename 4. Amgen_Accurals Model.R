
# Amgen accural model
setwd("C:\\Users\\fengy\\Desktop\\Summer\\2. Financial Accting\\Final")
df = read.csv('amgen_compustate_2386.csv')

library(magrittr)
library(dplyr)

df$accurals = df$ni - df$oancf
df$cashrev = df$revt - df$rect

# create previous year cashrev
df2 <- df[,c('gvkey','fyear','cashrev')]
df3 <- mutate(df2, fyear = fyear + 1) %>%
  rename(., pre_cashrev = cashrev)
df <- left_join(df, df3, by = c('gvkey',"fyear"))

df$delta_cashrev <- df$cashrev - df$pre_cashrev

# create previous year asset
df4 <- df[,c('gvkey','fyear','at')]
df5 <- mutate(df4, fyear = fyear + 1) %>%
  rename(., pre_at = at)
df <- left_join(df, df5, by =c('gvkey','fyear'))

# create scaled cash rev growth & scaled ppe
df$scale_cashrev_growth <- df$delta_cashrev / df$pre_at
df$scale_ppe <- df$ppegt / df$pre_at

## year 2017 OLS
y17 <- df[df['fyear'] == '2017',]
y17_line <- lm(y17$accurals ~ y17$scale_cashrev_growth + y17$scale_ppe)
summary(y17_line)
mean(y17_line$residuals)
y17_line$residuals[1]

## year 2016 OLS
y16 <- df[df['fyear'] == '2016',]
y16_line <- lm(y16$accurals ~ y16$scale_cashrev_growth + y16$scale_ppe)
summary(y16_line)
mean(y16_line$residuals)
y16_line$residuals

# Create a for loop to calculate Agmen residual 
df1 <- select(df, gvkey, fyear, accurals,scale_cashrev_growth, scale_ppe)
df1 = na.omit(df1)

year = list()
residual_a = list()

for (i in 1:29){
  data1 <- df1[df1['fyear'] == i + 1988, ]
  fit <- lm(accurals ~ scale_cashrev_growth + scale_ppe, data = data1)
  year[i] = i + 1988
  residual_a[i] = fit$residuals[1]
}

residuals_list = do.call(rbind,
                  lapply(1:length(year),
                         function(i)
                           data.frame(A=unlist(year[i]),
                                      B=unlist(residual_a[i]))))

residuals_list$B = abs(residuals_list$B)

plot(residuals_list,  type="l", xlab = 'Year', ylab = 'Residuals', 
     main = 'Yearly Unsigned Discretionary Accruals for Amgen')






