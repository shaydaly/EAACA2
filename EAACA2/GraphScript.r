#Sets working directory to location of relevant files
setwd(dirname(parent.frame(2)$ofile))

#reads the system results from result.dat into systemData , ignoring the header in the file
systemData <- read.table("results.dat", header=TRUE)

#Time - T is 10 as this was the interval specified in my bash script for capturing the information
T <- 10

#Utilisation - is based on the known idle time that was worked out in the bash scipt, subtracted from 100
UI <- (100-systemData$IDLE)

#System Throughput - (XO) is gotten from the number of completed transactions divided by the time interval T
XO <- (systemData$CO/T)

#Service demand - Utilisation is gotten by dividing UI by System throughput
DI <- (UI / XO)

#Response Time - gotten by dividing the total number of users by throughput
R <- (systemData$N / XO)

#dev.new() this command plots all the graphs at the same time in seperate graphs
dev.new()

#pch the following commands plot the graphs based on the calculations above, using solid circles for the points. 
plot(UI, pch=16, main="Utilisation (UI)", xlab="Number of Users (N)", ylab="Utilisation (%)", col="blue")
#the following commands where used to map the max UI using a dashed line on the graph
maxUtil <- summary(UI)["Max."]
abline(h=maxUtil,col="grey",lty=2)
text(x=10, y=maxUtil, labels="Max UI", adj=c(1.1,1), col='grey')

#the following is the graph for the Service Demand
dev.new()
plot(DI, pch=16, main="Service Demand (Di)", xlab="Number of Users (N)", ylab="Time in seconds(DI)", col="blue")
avgDI <- summary(DI)["Median"]
abline(h=avgDI,col="navy",lty=2)
text(x=40, y=6.5, labels="Avg Di", adj=c(1.1,1), col='navy')

dev.new()
plot(XO, pch=16, main="Throughput (XO)", xlab="Number of Users (N)", ylab="Transactions per Second (X0)", col="blue")
#The following commands are used to graph the max throughput dashed line on the graph
maxThrough <- summary(XO)["Max."]
abline(h=maxThrough,col="grey",lty=2)
text(x=maxThrough, y=maxThrough+0.7, labels="Max Xo", adj=c(1.1,1), col='grey')

dev.new()
plot(R, pch=16, main="Response Time (R)", xlab="Number of Users (N)", ylab="Response Time in seconds(R)", col="blue")

#The following summary command was used to retrieve the summary information for the different metrics displayed in the report.
#summary(UI), summary(DI), summary(XO), summary(R)