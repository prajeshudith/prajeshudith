#Importing Library
library(ICSNP)

#Importing Data
data = read.csv(file.choose())

#Spliting the first 2 columns as Arts and next 2 as Science
Arts = data[c(1,2)]
Science = data[c(3,4)]

#Claculating X1.bar
x1bar = apply(Arts,MARGIN = 2,FUN = mean)
x1bar

#Claculating X2.bar
x2bar = apply(Science,MARGIN = 2,FUN = mean)
x2bar

#Calculating N
N = nrow(data)
N

#Calculating S
S = var(data)
S

#Splitting the S
S11 = S[1:2,1:2]
S12 = S[3:4,1:2]
S21 = S[1:2,3:4]
S22 = S[3:4,3:4]

#Calculating [S11-S12-S21+S22]^-1
solve_S = solve(S11-S12-S21+S22)
solve_S

#Difference between X1bar and X2bar
Xbar = x1bar - x2bar
Xbar

#Calculating T^2
T2 = 15*t(Xbar)%*%solve_S%*%Xbar
T2

#Test statistics
Test_stat = T2*(N-2)/2
Test_stat

#cacluating F value
F = qf(p=.05,df1 =2,df2 = (N-2),lower.tail = FALSE)
F

#Interpretation
if(Test_stat>F){
  print("Reject H0")
}else{
  print("Accept H0")
}
