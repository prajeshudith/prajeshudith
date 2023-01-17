#Importing the dataset
data = read.csv("C:/Users/vella/Downloads/College/Acedamics/Codes/Sampling/Ex2/Ex2.csv")

#Sample size
n = nrow(data)

##Calculaing population mean, var and MSE
Ybar = mean(data$Income)
variance = var(data$Income)
sigma_sq = variance * (n-1)/n

### WITH REPLACEMENT
##Creting the table
#Getting the 1st samples
col_1 = c()
for (i in 1:n) {
  for (j in 1:n) {
    x = data[i,2]
    col_1 = append(col_1,x)
  }
}

#Getting the 2nd samples
col_2 = c()
for (i in 1:n) {
  for (j in 1:n) {
    x = data[j,2]
    col_2 = append(col_2,x)
  }
}

#Combing and making it into a single dataframe
With_replacement = cbind.data.frame(col_1,col_2)

#Calculating mean column
With_replacement$mean = rowMeans(With_replacement)

#Calculating var column
for (i in 1:nrow(With_replacement)) {
  With_replacement$var[i] = var(c(With_replacement$col_1[i],With_replacement$col_2[i]))
}

#Calculating expectation of y_bar
sample_mean_WR = mean(With_replacement$mean)

#Calculaitng variance of y_bar
sample_var_WR = ((n-1)/(n*2))*variance

#Calculating expectation of s^2
Expt_sample_var_WR = mean(With_replacement$var)



###WITHOUT REPLACEMENT
##CREATING THE TABLE
#Getting the units in 1st sample
a = list()
for (i in 1:4) {
  for (j in 1:i) {
    a = c(4-i+1,a)
  }
}

#Getting the units in 2nd sample
b = list()
i = 2
while (i<6) {
  for (j in i:5) {
    b = c(b,j)
  }
  i = i+1
}

#Getting the values of 1st samples
column_1 = c()
for (i in a) {
  x = data[i,2]
  column_1 = append(column_1,x)
}

#Getting the values of 2nd sample
column_2 = c()
for (i in b) {
  x = data[i,2]
  column_2 = append(column_2,x)
}

#Combing the column into 1 dataframe
Without_replacement = cbind.data.frame(column_1,column_2)

#Calculating the mean column
Without_replacement$mean = rowMeans(Without_replacement)

#Calculating the var column
for (i in 1:nrow(Without_replacement)) {
  Without_replacement$var[i] = var(c(Without_replacement$column_1[i],Without_replacement$column_2[i]))
}

#Calculating expectation of y_bar
sample_mean_WOR = mean(Without_replacement$mean)

#Calculaitng variance of y_bar
sample_var_WOR = ((n-2)/(n*2))*variance

#Calculating expectation of s^2
Expt_sample_var_WOR = mean(Without_replacement$var)

##Result
#1st sub division
Ybar
variance
sigma_sq

#SRSWR
if(Ybar == sample_mean_WOR){
  cat("Sample mean:",sample_mean_WOR,"is an unbiased estimator of population mean in SRSWR")
}

sample_var_WR

if(round(sigma_sq,2) == round(Expt_sample_var_WR,2)){
  cat("Sample variance:",Expt_sample_var_WR,"is an unbiased estimator of population variance in SRSWR")
}

#SRSWOR
if(Ybar == sample_mean_WOR){
  cat("Sample mean:",sample_mean_WOR,"is an unbiased estimator of population mean in SRSWR")
}

sample_var_WOR

if(round(variance,2) == round(Expt_sample_var_WOR,2)){
  cat("Sample variance:",Expt_sample_var_WOR,"is an unbiased estimator of population variance in SRSWR")
}
