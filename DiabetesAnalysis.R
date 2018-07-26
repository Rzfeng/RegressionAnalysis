insurance <- read.csv("~/Downloads/SAHIE_31OCT16_00_13_53_49.csv")
Diabetes <- read.csv("~/Downloads/DM_PREV_ALL_STATES.csv", header=TRUE)
View(insurance)
uninsured.percentage <- insurance$Uninsured...
#wyoming
insurance <- insurance[-3170, ]
insurance <- insurance[-3097, ]
insurance <- insurance[-3041, ]
insurance <- insurance[-3001, ]
insurance <- insurance[-2867, ]
insurance <- insurance[-2852, ]
insurance <- insurance[-2822, ]
insurance <- insurance[-2567, ]
insurance <- insurance[-2471, ]
insurance <- insurance[-2404, ]
insurance <- insurance[-2357, ]
insurance <- insurance[-2351, ]
insurance <- insurance[-2283, ]
insurance <- insurance[-2246, ]
insurance <- insurance[-2168, ]
insurance <- insurance[-2079, ]
insurance <- insurance[-2025, ]
insurance <- insurance[-1924, ]
insurance <- insurance[-1861, ]
insurance <- insurance[-1827, ]
insurance <- insurance[-1805, ] 
insurance <- insurance[-1794, ]
insurance <- insurance[-1776, ]
insurance <- insurance[-1682, ]
insurance <- insurance[-1625, ]
insurance <- insurance[-1509, ]
insurance <- insurance[-1426, ]
insurance <- insurance[-1338, ]
insurance <- insurance[-1254, ]
insurance <- insurance[-1239, ]
insurance <- insurance[-1214, ]
insurance <- insurance[-1197, ]
insurance <- insurance[-1132, ]
insurance <- insurance[-1011, ]
insurance <- insurance[-905, ]
insurance <- insurance[-8052004, ]
insurance <- insurance[-712, ]
insurance <- insurance[-610, ]
insurance <- insurance[-564, ]
insurance <- insurance[-558, ]
insurance <- insurance[-398, ]
insurance <- insurance[-330, ]
insurance <- insurance[-324, ]
insurance <- insurance[-315, ]
insurance <- insurance[-250, ]
insurance <- insurance[-191, ]
insurance <- insurance[-115, ]
insurance <- insurance[-99, ]
insurance <- insurance[-69, ]
insurance <- insurance[-1, ]

Diabetes <- Diabetes[-3148:-3225, ]
Diabetes$X.1
Diabetes <- Diabetes[-1, ]
Code<-list(Diabetes$X)
Code2<-list(insurance$ID)
name<-list(insurance$Name)
name1<-list(Diabetes$X.1)
plot(uninsured.percentage, Diabetes$X.2)


