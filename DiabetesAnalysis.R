---
title: "Regression Analysis on Diabetes"
author: "Richard Feng"
output: pdf_document
---

```{r}
Diabetes <- read.csv("~/Downloads/333_Proj/DM_PREV_ALL_STATES.csv")
insurance <- read.csv("~/Downloads/333_Proj/insurance.csv")
poverty <- read.csv("~/Downloads/333_Proj/est13ALL-2.csv")
restaraunt <- read.csv("~/Downloads/333_Proj/restaraunt.csv")

#puerto rico data
Diabetes <- Diabetes[-3147:-3225, ]


```

```{r}
#install.packages("acs")
library(acs)
#install.packages("dplyr")
library(dplyr)
#install.packages("blscrapeR")
library(blscrapeR) #get data
#install.packages("choroplethr")
library(choroplethr) # make maps
#install.packages("choroplethrMaps")
library(choroplethrMaps)

#Subset of important restaraunt columns
restaraunt = subset(restaraunt, select = c("FIPS", "FFR11", "FSR11"))
restaraunt$FIPS = as.numeric(restaraunt$FIPS)
restaraunt$ID = restaraunt$FIPS
restaraunt$FFR11 = as.numeric(restaraunt$FFR11)
restaraunt$FSR11 = as.numeric(restaraunt$FSR11)

#Subset of important poverty columns
poverty$FIPS = poverty$State*1000 + poverty$County
poverty = subset(poverty, select=c("Poverty.Estimate..All.Ages", "Poverty.Percent..All.Ages", "FIPS"))
colnames(poverty)=c("Number Poverty", "Percent Poverty", "ID")
poverty$ID = as.numeric(poverty$ID)
poverty$`Percent Poverty` = as.numeric(as.character(poverty$`Percent Poverty`))


#Subset of important Diabetes columns
Diabetes=subset(Diabetes,select=c("FIPS.Codes","number.8", "percent.8"))
colnames(Diabetes)=c("ID", "Number of Diabetes", "Percentage Diabetes")
Diabetes$ID=as.numeric(Diabetes$ID)
Diabetes$`Percentage Diabetes` = as.numeric(as.character(Diabetes$`Percentage Diabetes`))


```


```{r}
#Plotting Poverty
new = poverty[,c(3,2)]
colnames(new)=c("region","value")
county_choropleth(new, title = "Percentage in Poverty")

#Plotting Fast Food Restaraunts
new.fast = restaraunt[,c(1,2)]
colnames(new.fast) = c("region", "value")
which(duplicated(new.fast[,1]))
new.fast = new.fast[-257,]
new.fast$value = as.numeric(new.fast$value)
new.fast$region = as.numeric(new.fast$region)
county_choropleth(new.fast, title = "Number of Fast Food Chains in Region")

```

```{r}
#Plotting residuals
#Combine Data
combined.poverty = right_join(Diabetes, poverty, by = "ID" )
combined.uninsurance = right_join(Diabetes, insurance, by = "ID")
combined.restaraunt = right_join(Diabetes, restaraunt, by = "ID" )
combined.restaraunt = combined.restaraunt[,-4]

#Attempting to plot Residuals of Diabetes vs. Poverty 
bad = which(rowSums(is.na(combined.poverty)) > 0)
new.combined.pov = combined.poverty[-bad, ]
fit.pov = lm((combined.poverty$`Percentage Diabetes`)~ ((combined.poverty$`Percent Poverty`)))
new.combined.pov$residuals = fit.pov$residuals
new.poverty = new.combined.pov[,c(1,6)]
colnames(new.poverty) = c("region", "value")
county_choropleth(new.poverty, title = "Residuals Poverty")
new.poverty$yhat= new.poverty$value

#Yhat Diabetes vs. Poverty
summary(fit.pov)
y = length(new.poverty$value)
for (i in 1:y) 
  new.poverty$yhat[i] = 1.571177 + 0.294131*new.combined.pov$`Percent Poverty`[i]
#View(new.poverty)
new4 = new.poverty[,c(1,3)]
colnames(new4) = c("region", "value")
county_choropleth(new4, title = "Yhat poverty")

#Diabetes vs. Resteraunt; plot residuals
bad1 = which(rowSums(is.na(combined.restaraunt)) > 0)
fit.rest = lm(combined.restaraunt$`Percentage Diabetes` ~ combined.restaraunt$FFR11)
#Look at qq plot (doe sit fit trendline), and do you see any patterns in residuals
new.combined.restaraunt = combined.restaraunt[-bad1, ]
new.combined.restaraunt$residuals = fit.rest$residuals 
#View(new.combined.restaraunt)
new.combined = new.combined.restaraunt[,c(1,6)]
colnames(new.combined) = c("region", "value")
#View(new.combined)
which(duplicated((new.combined)))
new.combined = new.combined[-248,]
county_choropleth(new.combined, title = "Residuals Restaraunt")

#Yhat for Diabetes vs. Restaraunt
summary(fit.rest)
new.combined$yhat = new.combined$value
x = length(new.combined$value)
for (i in 1:x) {
  new.combined$yhat[i] = 11.2779328 + (-.0018351)*new.combined.restaraunt$FFR11[i] 
}
new.combined = new.combined[,c(1,3)]
colnames(new.combined) = c("region", "value")
county_choropleth(new.combined, title = "Yhat Restaraunt")

```




