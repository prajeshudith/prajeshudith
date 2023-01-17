#Importing data
data = read.csv(file.choose(),header = FALSE)

#Converting the data into a matrix
data = data.matrix(data)

#Fetching the parameters given in the question
N = 300
P1 = 1
P2 = 2
P3 = 2

#Calculating P value
P = P1+P2+P3

#Calculating the determinant value of the matrix
R = det(data)

#Calculating f
f = (P^2)/2 - (((P1^2)+(P2^2)+(P3^2))/2)

#Calculating f
L = (3/2) + (P^3-((P1^3)+(P2^3)+(P3^3)))/(6*f)

###Calculating the product of Rii
##This is the what we need
# det(data.matrix(data[0:1,0:1]))
# det(data.matrix(data[2:3,2:3]))
# det(data.matrix(data[4:5,4:5]))

##Doing the same through automation
a = 1
for (i in c(1,3,5)){
    a = a*(det(data.matrix(data[((i-1):i),((i-1):i)])))
    print(i)
}          
a

#Calculating lambda value
lambda = R/a

#Calculating the Test statistics
Test_stat = -(N-L)* log(lambda)

#cacluating Chi-square value value
chi_sq = qchisq(0.05,f, lower.tail=FALSE)
chi_sq

#Interpretation
if(Test_stat>chi_sq){
  print("Reject H0")
}else{
  print("Accept H0")
}
