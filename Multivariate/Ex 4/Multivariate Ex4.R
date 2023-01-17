#Importing Library
library(ICSNP)

#Importing Data
data = read.csv(file.choose())

#Finding N1 and N2
N = nrow(data)
N

#p is No.of parameters
p = ncol(data)
p

#Calculating Y table
Y = data.frame()
for(i in 1:(ncol(data)-1)){
  for (j in 1:nrow(data)){
    Y[j,i] = data[j,i] - data[j,i+1]
  }
}

#Finding N1 and N2
N = nrow(Y)
N

#p is No.of parameters
p = ncol(Y)
p

#Claculating X.bar
Ybar = apply(Y,MARGIN = 2,FUN = mean)
Ybar

#Calculating S
S = var(Y)
S

#Calculating S inverse
s_inv = solve(S)
s_inv

#Calculating Ybar transpose
Y_trans = t(Ybar)
Y_trans

#Caluclating T^2
T2 = (N)*(Y_trans%*%s_inv%*%Ybar)
T2

#Calculating Test Statistic
Test_stat = (T2*(N-p+1))/(p-1)
Test_stat

#cacluating F value
F = qf(p=.05,df1 =(p-1),df2 = (N-p+1),lower.tail = FALSE)
F

#Interpretation
if(Test_stat>F){
  print("Reject H0")
}else{
  print("Accept H0")
}
