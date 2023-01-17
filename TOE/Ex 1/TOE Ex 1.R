#Importing libraries
library(ggplot2)

#Importing data
data = read.csv(file.choose())

#Mean
Xbar = mean(data$X)
Xbar

#N
N = nrow(data)
N

#Creating the table
Y = data.frame()
for (i in 1:nrow(data)) {
  Y[i,1] = exp(-data$X[i]/Xbar)
}
for (j in 1:nrow(data)) {
  Y[j,2] = (1-(data$X[j]/(N*Xbar)))^(N-1)
}
Y[,3] = data$X

#Renaming the columns
names(Y)[1] = "Rcap_MLE"
names(Y)[2] = "Rcap_UMVUE"
names(Y)[3] = "Time"


#Plotting the graph
ggplot(Y,aes(Time),color = "red")+
  geom_line(aes(Time,Rcap_MLE),color = "blue")+
  geom_line(aes(Time,Rcap_UMVUE),color = "red")
