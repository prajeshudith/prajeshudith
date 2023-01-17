#Importing Library
library(ICSNP)

#Importing Data
data = read.csv(file.choose())

#Claculating X.bar
xbar = apply(data,MARGIN = 2,FUN = mean)
xbar

#Calcukating S
S = var(data)
S

#mu which is given in the sum
mu= c(65,70,65,75)

#n is NO.of data
n = nrow(data)
n

#p is No.of parameters
p = ncol(data)
p

#Caluculating T^2
T2 = as.numeric(n*(t((xbar-mu))%*%solve(S)%*%(xbar-mu)))

#Calculating Test Statistics manually
#Test_stat = (T2*(n-p))/(p*(n-1))
#Test_stat

#This is what we have done in observation but it is wrong 
Test_stat = (T2*(n-p))/(p)
Test_stat
  
#Calculating Test Statistics using package
#test_stat = HotellingsT2(data,mu=mu,test = "f")
#test_stat

#cacluating F value
F = qf(p=.05,df1 =p,df2 = (n-p),lower.tail = FALSE)
F

#Interpretation
if(Test_stat>F){
  print("Reject H0")
}else{
  print("Accept H0")
}
