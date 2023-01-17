#Importing dataset
data = read.csv(file.choose(),header = TRUE)

#Modifying data as required to plot
data_1 = data
row.names(data_1) = data$States
data_1 = data_1[,-1]

#Single linkage
c <- cor(t(data_1), method="pearson") 

d <- as.dist(1-c)

hr <- hclust(d, method = "single", members=NULL)

plot(as.dendrogram(hr), edgePar=list(col=3, lwd=4), horiz=T, main = "Single linkage") 

#complete linkage
c <- cor(t(data_1), method="kendall") 

d <- as.dist(1-c)

hr <- hclust(d, method = "complete", members=NULL)

plot(as.dendrogram(hr), edgePar=list(col=3, lwd=4), horiz=T, main = "Complete linkage") 

#complete linkage
c <- cor(t(data_1), method="kendall") 

d <- as.dist(1-c)

hr <- hclust(d, method = "average", members=NULL)

plot(as.dendrogram(hr), edgePar=list(col=3, lwd=4), horiz=T, main = "Average linkage") 
