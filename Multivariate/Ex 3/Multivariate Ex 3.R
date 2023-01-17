#Importing Library
library(ICSNP)

#Importing Data
data = read.csv(file.choose())

#Spliting the first 3 columns as Urban and next 3 as rural
Urban = data[c(1,2,3)]
Rural = data[c(4,5,6)]

#Finding the data 1 with minimum number of rows
if(nrow(Urban) < nrow(Rural)){
  data_1 = Urban
  data_2 = Rural
}else{
  data_2 = Urban
  data_1 = Rural
}

#Removing last row of data 1
data_1 = data_1[-nrow(data_1),]

#Finding N1 and N2
N1 = nrow(data_1)
N2 = nrow(data_2)

#p is No.of parameters
p = ncol(data_1)
p

#Calculating Y table
Y = data.frame()
for(i in 1:ncol(data_1)){
  for (j in 1:nrow(data_1)) {
    Y[j,i] = data_1[j,i] - (sqrt(N1/N2)*data_2[j,i])
  }
}

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
T2 = (N1)*(Y_trans%*%s_inv%*%Ybar)
T2

#Calculating Test Statistic
Test_stat = (T2*(N1-p))/p
Test_stat

#cacluating F value
F = qf(p=.05,df1 =p,df2 = (N1-p),lower.tail = FALSE)
F

#Interpretation
if(Test_stat>F){
  print("Reject H0")
}else{
  print("Accept H0")
}
