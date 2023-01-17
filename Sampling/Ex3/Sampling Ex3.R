#Importing the dataset
data = read.csv("C:/Users/vella/Downloads/College/Acedamics/Codes/Sampling/Ex3/Ex3.csv")

#Given Populating size and X
N = 84
X = 74488
#Sample size
n = nrow(data)

#Finding Xbar and Ybar
Xbar =  mean(data$X)
Ybar =  mean(data$Y)

#Finding Rcap,Ycap & YR_cap
Rcap = Ybar/Xbar
Ycap = N*Ybar
YR_cap = Rcap*X

#Finding var of X & Y and covaiance of X & Y and f
Sx_sq = var(data$X)
Sy_sq = var(data$Y)
Sxy = cov(data$X,data$Y)
f = n/N

#Calculating variance of Ycap
var_Ycap = (N^2)*(1-f)*Sy_sq/n

#Calculating variance of YRcap
var_YR_cap = ((1-f)*(N^2)*(Sy_sq+((Rcap^2)*Sx_sq)-(2*Rcap*Sxy)))/n

#Calculating relative precession
Relative_precession = (var_Ycap - var_YR_cap)*100/var_YR_cap

#Result
YR_cap
var_YR_cap
Ycap
var_Ycap
Relative_precession
