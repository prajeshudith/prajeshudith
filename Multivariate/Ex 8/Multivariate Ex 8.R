#Importing data
data = read.csv(file.choose(),header = TRUE)

#Spliting the dataset
Sample_1 = data[c(1,2,3)]
Sample_2 = data[c(4,5,6)]

#Removing last row of data
Sample_2 = Sample_2[1:20,]

#Finding N1,N2,N,Q and P
N1 = nrow(Sample_1)
N2 = nrow(Sample_2)
N = N1+N2
P = ncol(Sample_1)
Q = 2

#Calcukating A = S*(n-1)
A1 = var(Sample_1)*(N1-1)
A1

A2 = var(Sample_2)*(N2-1)
A2

A = A1+A2
A

#Calculating Values for lambda
mod = (det(A))^((N-1)/2)
mod_1 = (det(A1))^((N1-1)/2)
mod_2 = (det(A2))^((N2-1)/2)

prod_mod = mod_1*mod_2

Nj = (N-1)^(((N-1)*P)/2)

Nj_1 = (N1-1)^(((N1-1)*P)/2)
Nj_2 = (N2-1)^(((N2-1)*P)/2)
prod_Nj = Nj_1*Nj_2

#Calculating lambda
lambda = (prod_mod*Nj)/(mod*prod_Nj)

#Calculating lambda
rho = 1 - (((1/(N1-1))+(1/(N2-1))-(1/(N-1)))*(((2*(P^2))+(3*P)-1)/(6*(P+1)*(Q-1)))) 
rho

#Calculating Test statistics
Test_stat = -rho*log(lambda)
Test_stat

#Calculating f
f = 1/2*((Q-1)*(P+1)*P)
f

#cacluating Chi-square value value
chi_sq = qchisq(0.05,f, lower.tail=FALSE)
chi_sq

#Interpretation
if(Test_stat>chi_sq){
  print("Reject H0")
}else{
  print("Accept H0")
}
