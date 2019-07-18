# Describe the dataset

# DATASET 1
# *The Karn and Penrose Data set*
This data set are from Mary N. Karn and L. S. Penrose published in the “Annals of Eugenics” titled "Birth Weight and gestation time in relation to maternal age, parity and infant survival"  published in 1951.  
The data represent the survivorship of male babies within the first week of birth based on the weight and time of gestation.  
The file contains contiens 4051 babies from the years 1935 y 1946. The file has 4 columns: 

1.	Line_number
2.	Gestation_Time_days;  Gestation time from day of conception to day of birth
3.	Weight_lb; the weight of the babies in pounds
4.	Survival: "1" or "0"

# Objectives:
1. Model the probability of survival as a function of gestation time
2. Model the average weight of the new-born as a function of  the gestation period. 

First look at the data. 
*Make sure your directory is set correctly and the required file is present in the directory. Use `getwd` and `setwd` to do this.

```
birth<-read.csv("Karn_Penrose_Infant_Survivorship_QUBES.csv")

head(birth)
  row_num Survival Weigth_lb Gestation_Time_days
1       1        0       1.0                 155
2       2        0       1.0                 165
3       3        0       1.0                 165
4       4        0       5.5                 170
5       5        0       1.0                 180
6       6        0       1.5                 180


summary(birth)
    row_num        Survival       Weigth_lb      Gestation_Time_days   
 1st Qu.:1014   1st Qu.:1.000   1st Qu.: 6.000   1st Qu.:265.0      
 Median :2026   Median :1.000   Median : 7.000   Median :280.0      
 Mean   :2026   Mean   :0.923   Mean   : 7.015   Mean   :276.2      
 3rd Qu.:3039   3rd Qu.:1.000   3rd Qu.: 8.000   3rd Qu.:295.0      
 Max.   :4052   Max.   :1.000   Max.   :13.000   Max.   :345.0  
 Min.   :   1   Min.   :0.000   Min.   : 1.000   Min.   :155.0      
 1st Qu.:1014   1st Qu.:1.000   1st Qu.: 6.000   1st Qu.:265.0      
 Median :2026   Median :1.000   Median : 7.000   Median :280.0      
 Mean   :2026   Mean   :0.923   Mean   : 7.015   Mean   :276.2      
 3rd Qu.:3039   3rd Qu.:1.000   3rd Qu.: 8.000   3rd Qu.:295.0      
 Max.   :4052   Max.   :1.000   Max.   :13.000   Max.   :345.0   

```

# Obj.1: Modeling survial probability 
What is the response and predictor variable based on the dataset? 
Now utilize a series of plots to visualise the response and predictor variables. *You are required to enter the response and predictor variables in the snippet below*.


```{r}
R<-
P<-
par(mfrow=c(1,2))
par(mfrow=c(1,2))
hist(birth [,R],main="Histogram of response variable",col="firebrick",xlab=R)
hist(birth[ ,P],main="Histogram of predictor variable", col="orange",xlab=P)
```


<embed src="https://github.com/mitramenon/QUBES-GLaMorous-minds/blob/master/images/HIST1.pdf" width="500" height="375" type="application/pdf">

```{r}
plot(birth[ ,P],birth[ ,R],xlab="Predictor",ylab="Response")

```

There are two model choices for you here: `logistic` or `linear` regression. All of these are implemented within the `glm` function in `R`.
Based on the historgram and the summary generated above which model will you use to address this question.

Below are the series of commands corresponding to logistic and linear regression. You will utilize your intution to run one of these snippets of code. 

```{r}
model1<-glm (birth[ ,R] ~ birth[ ,P],  family = binomial ())
model2<-glm(birth[ ,R] ~ birth[ ,P], family=gaussian())

```



