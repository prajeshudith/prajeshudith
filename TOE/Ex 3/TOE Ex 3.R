#Importing Data
data = read.csv(file.choose())

#Splitting X and Y matrices
X = data.matrix(data[,c(1,3,4)])
X[,1] = 1
X

Y = data.matrix(data[2])
Y

#Finding X_dash_Y
X_dash_Y = t(X)%*%Y
X_dash_Y

#Finding (X_dash_X)^-1
X_dash_X_inv = solve(t(X)%*%X)
X_dash_X_inv

#Calculating estimate
Q_x = X_dash_X_inv%*%X_dash_Y
Q_x

#Inference
cat("Delivery time =",Q_x[1],"+",Q_x[2],"X1 +",Q_x[3],"X2")
