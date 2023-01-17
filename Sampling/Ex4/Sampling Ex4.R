#Importing the dataset
data = read.csv("C:/Users/vella/Downloads/College/Acedamics/Codes/Sampling/Ex4/Ex4.csv")

#Given Populating size and X
N = 84
X = 74488
#Sample size
n = nrow(data)

#Finding xbar and ybar & Xbar
xbar =  mean(data$X)
ybar =  mean(data$Y)
Xbar = X/N

#Finding Rcap,Ycap & YR_cap
Rcap = ybar/xbar
Ycap = N*ybar
YR_cap = Rcap*X

#Finding var of X & Y and covaiance of X & Y and f
Sx_sq = var(data$X)
Sy_sq = var(data$Y)
Sxy = cov(data$X,data$Y)
f = n/N
b = Sxy/Sx_sq

#Calculating variance of Ycap
var_Ycap = (N^2)*(1-f)*Sy_sq/n

#Calculating variance of YRcap
var_YR_cap = ((1-f)*(N^2)*(Sy_sq+((Rcap^2)*Sx_sq)-(2*Rcap*Sxy)))/n

#Calculating regression estimator ybar_lr
ybar_lr = ybar+b*(Xbar-xbar)
y_lr = N*ybar_lr
var_y_lr = ((1-f)*(N^2)*(Sy_sq+((b^2)*Sx_sq)-(2*b*Sxy)))/n

#Calculating relative precession
Over_simple_mean_per_unit = (var_Ycap - var_y_lr)*100/var_y_lr
Over_ratio_estimate = (var_YR_cap - var_y_lr)*100/var_y_lr

#Result
YR_cap
var_YR_cap
Ycap
var_Ycap
y_lr
var_y_lr
Over_simple_mean_per_unit
Over_ratio_estimate
