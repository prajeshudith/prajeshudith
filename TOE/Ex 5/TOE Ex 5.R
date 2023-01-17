#Importing dataset
data = read.csv(file.choose())

#PART A
sample_1 = data[1]
n_1 = nrow(sample_1)
alpha_1 = 0.05

alpha_bar_1 = mean(sample_1$X)

s_1 = var(sample_1$X)
s_by_rt_n = s_1/sqrt(n_1)

t_1 = -qt((alpha_1/2),(n_1-1))

L = 2*t_1*s_by_rt_n

#PART B
sample_2 = data[2]

alpha_2 = 0.10

n_2 = nrow(sample_2)

sum_x = sum(sample_2$Y)

xbar = mean(sample_2$Y)

chi_1 = qchisq((alpha_2/2),(2*n_2),lower.tail = FALSE)
chi_2 = qchisq((1-(alpha_2/2)),(2*n_2),lower.tail = FALSE)

LCL = (chi_1)/(2*sum_x)
UCL = (chi_2)/(2*sum_x)

C_I = paste0("(",LCL,",",UCL,")")

mean_time_failure = 1/xbar

C_I_2 = paste0("(",(1/LCL),",",(1/UCL),")")

t =100
LL = exp(-(LCL*t))
UL = exp(-(UCL*t))

C_I_3 = paste0("(",LL,",",UL,")")

#RESULTS
cat("The 95% shortest length of the confidence interval is :",L)
cat("The 90% confidence interval for the mean time of failure of 
    the electric component is :",C_I_2)
cat("The 90% confidence interval for the probability that the 
    component reaches 8 works without failure for 100 hours is :",C_I_3)
