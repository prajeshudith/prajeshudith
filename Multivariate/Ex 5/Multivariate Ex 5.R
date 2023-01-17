#Importing Library
library(ICSNP)
library(SciViews)#for natural log

#Importing Data
data = read.csv(file.choose())

#Spliting the dataset
A_1 = data[c(1,2,3)]
A_2 = data[c(4,5,6)]
A_3 = data[c(7,8,9)]

#Removing last row of data
A_2 = A_2[-nrow(A_2),]
A_3 = A_3[-c(nrow(A_3),(nrow(A_3)-1)),]

#Finding N1 and N2
N1 = nrow(A_1)
N2 = nrow(A_2)
N3 = nrow(A_3)

#Finiding individual means
A11 = mean(unlist(A_1[1]))
A11

A12 = mean(unlist(A_1[2]))
A12

A13 = mean(unlist(A_1[3]))
A13

A21 = mean(unlist(A_2[1]))
A21

A22 = mean(unlist(A_2[2]))
A22

A23 = mean(unlist(A_2[3]))
A23

A31 = mean(unlist(A_3[1]))
A31

A32 = mean(unlist(A_3[2]))
A32

A33 = mean(unlist(A_3[3]))
A33

#Calculating mean
X1Bar = apply(A_1,MARGIN = 2,FUN = mean)
X1Bar

X2Bar = apply(A_2,MARGIN = 2,FUN = mean)
X2Bar

X3Bar = apply(A_3,MARGIN = 2,FUN = mean)
X3Bar

#Calcukating A = S*(n-1)
A1 = var(A_1)*(N1-1)
A1

A2 = var(A_2)*(N2-1)
A2

A3 = var(A_3)*(N3-1)
A3

#Combined mean
Xbar = ((N1*X1Bar)+(N2*X2Bar)+(N3*X3Bar))/(N1+N2+N3)
Xbar

#Calculating B
B1 = N1*(X1Bar-Xbar)%*%t(X1Bar-Xbar)
B1

B2 = N1*(X2Bar-Xbar)%*%t(X2Bar-Xbar)
B2

B3 = N1*(X3Bar-Xbar)%*%t(X3Bar-Xbar)
B3

B = B1+B2+B3
B

#Calculating A, determinant of A, A+B and Determinant of A+B
A = A1+A2+A3
A

det_A = det(A)

A_B = A+B
A_B

det_A_B = det(A_B)

#Likelihood ration
LR = det_A/det_A_B
LR

#Calculating N
N = N1+N2+N3
N

#Calculating P and Q
P = ncol(A1)
Q = ncol(data)/3

#Calculating m
m = ((N-1)-(P+Q))/2
m

#Calculating test statistics
Test_stat = -m*ln(LR)
Test_stat

#cacluating Chi-square value value
chi_sq = qchisq(0.05,6, lower.tail=FALSE)
chi_sq

#Interpretation
if(Test_stat>chi_sq){
  print("Reject H0")
}else{
  print("Accept H0")
}
