#Importing the dataset
data = read.csv(file.choose(),header = FALSE)

#Population total as given in the problem
N = 432

#Sample size
n = nrow(data)

#Sample mean and Var
avg = mean(data$V2)
variance = var(data$V2)

#Calculating variance of Ybar
V_y_bar = ((N-n)/(N*n))*variance

#Std error of y
S.E_y = sqrt(V_y_bar)/avg

#Calculating Y_cap
Y_cap = N*avg

#Calculating variance of Y_cap
var_Y_cap = (N^2)*V_y_bar

#sed error of Y_cap
S.E_Y_cap = sqrt(var_Y_cap)
