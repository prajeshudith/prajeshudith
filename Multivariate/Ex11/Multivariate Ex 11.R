#Importing dataset
data = read.csv(file.choose())

#Spliting the data as 2 samples
sample_1 = data[c(1,2,3,4)]
sample_2 = data[c(5,6,7,8)]
Unknown_sample = data[c(9,10,11,12)]

#FOR SAMPLE 1
#Claculating X1.bar
x1bar = apply(sample_1,MARGIN = 2,FUN = mean)
x1bar

#n1 is NO.of data in Urban
n1 = nrow(sample_1)
n1

#Calcukating A1 = S*(n-1)
A1 = var(sample_1)*(n1-1)
A1

#p is No.of parameters
p = ncol(Urban)
p

##FOR SAMPLE 2
#Removing last row as it is empty
sample_2 = sample_2[-c(16,15,14,13),]

#Claculating X2.bar
x2bar = apply(sample_2,MARGIN = 2,FUN = mean)
x2bar

#n2 is NO.of data in Rural
n2 = nrow(sample_2)
n2

#Calcukating A2 = S*(n-1)
A2 = var(sample_2)*(n2-1)
A2

#Calculating A = A1+A2
A = A1+A2
A

#calculating S = A/(n1+n2-2)
S = A/(n1+n2-2)
S

#CALCULATING S INVERSE, x1bar-x2bar, mean_sum_trans
s_inv = solve(S)
s_inv

mean_diff = (x1bar-x2bar)

mean_sum = x1bar+x2bar
mean_sum_trans = t(mean_sum)
mean_sum_trans

#CALCULATING THE NUMBER OF MISCLASSIFICATIONS IN SAMLPE 1
LHS = (mean_sum_trans%*%s_inv%*%mean_diff)/2
rhs = s_inv%*%mean_diff

d = list()
y = 0
for (i in 1:nrow(sample_1)) {
  for (j in 1:ncol(sample_1)) {
    x = sample_1[i,j]*rhs[j]
    y = y + x
  }
  d[i] = y
  y = 0
}

RHS_1 = t(as.data.frame(d))

T_F_1 = list()
for (i in 1:nrow(RHS_1)) {
  T_F_1 = append(T_F_1 ,(RHS_1[i] > LHS))
}

sample_1_miss = length(T_F_1[T_F_1 == FALSE])

#CALCULATING THE NUMBER OF MISCLASSIFICATIONS IN SAMLPE 2
e = list()
y = 0
for (i in 1:nrow(sample_2)) {
  for (j in 1:ncol(sample_2)) {
    x = sample_2[i,j]*rhs[j]
    y = y + x
  }
  e[i] = y
  y = 0
}

RHS_2 = t(as.data.frame(e))

T_F_2 = list()
for (i in 1:nrow(RHS_2)) {
  T_F_2 = append(T_F_2 ,(RHS_2[i] < LHS))
}

sample_2_miss = length(T_F_2[T_F_2 == FALSE])

#Calculating the error rate
E_r = (sample_1_miss+sample_2_miss)*100/(n1+n2)

#Classifying the unknown samples
#Removing last row as it is empty
Unknown_sample = Unknown_sample[c(1,2,3),]

f = list()
y = 0
for (i in 1:nrow(Unknown_sample)) {
  for (j in 1:ncol(Unknown_sample)) {
    x = Unknown_sample[i,j]*rhs[j]
    y = y + x
  }
  f[i] = y
  y = 0
}

RHS_sample = t(as.data.frame(f))

T_F_sample = list()
for (i in 1:nrow(RHS_sample)) {
  T_F_sample = append(T_F_sample ,(RHS_sample[i] > LHS))
}

#Result
for (i in 1:nrow(RHS_sample)) {
  if(T_F_sample[i] == "TRUE")
    cat("\nSample ",i," belongs to sample 1 ")
  else
    cat("\nSample ",i," belongs to sample 2")
}

cat("The error rate is ",E_r)
