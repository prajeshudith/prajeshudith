#Importing Library
library(ICSNP)
library(Hotelling)

#Importing Data
data = read.csv(file.choose())

#Spliting the first 3 columns as Urban and next 3 as rural
Urban = data[c(1,2,3)]
Rural = data[c(4,5,6)]


###CALCULATING MANUALLY
##FOR URBAN
#Claculating X1.bar
x1bar = apply(Urban,MARGIN = 2,FUN = mean)
x1bar

#n1 is NO.of data in Urban
n1 = nrow(Urban)
n1

#Calcukating A1 = S*(n-1)
A1 = var(Urban)*(n1-1)
A1

#p is No.of parameters
p = ncol(Urban)
p

##FOR RURAL
#Removing last row as it is empty
Rural = Rural[-16,]

#Claculating X2.bar
x2bar = apply(Rural,MARGIN = 2,FUN = mean)
x2bar

#n2 is NO.of data in Rural
n2 = nrow(Rural)
n2

#Calcukating A2 = S*(n-1)
A2 = var(Rural)*(n2-1)
A2

#Calculating A = A1+A2
A = A1+A2
A

#Calculating X1.bar - X2.bar
xbar = x1bar - x2bar
xbar = matrix(unlist(xbar))

#calculating S = A/(n1+n2-2)
S = A/(n1+n2-2)
S

x_trans = t(xbar)
x_trans
s_inv = solve(S)
s_inv

#Caluclating T^2
T2 = ((n1*n2)/(n1+n2))*(x_trans%*%s_inv%*%xbar)

###CALCULATING USING PACKAGE
#T2 = hotelling.test(Urban,Rural,var.equal = TRUE)

T2

#Test Statistic
Test_stat = T2*(n1+n2-p-1)/p
Test_stat

#cacluating F value
F = qf(p=.05,df1 =p,df2 = (n1+n2-p-1),lower.tail = FALSE)
F

#Interpretation
if(Test_stat>F){
  print("Reject H0")
}else{
  print("Accept H0")
}
