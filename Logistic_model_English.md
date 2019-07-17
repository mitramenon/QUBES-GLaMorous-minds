#Logistic regression model

# Explore your data through a histogram and determine if the data is binary and appropriate for logistic regression

Logistic regression is a special regression where the predictive variable (on the x-axis) is a continuous variable, and the response variable has only two alternatives. The alternatives are typically coded as 0 or 1, but can also be encoded as live / dead; present / absent; healthy / unhealthy; I win / lost; step / no step are alternatives among others.

There are also other types of logistic regression such as multinomial (multiple groups) and more complex extensions, but of these types we will not cover in this book. 

The objective of a logistic regression is to model the probability of an event based on an independent variable and determine if a "threshold" or a threshold in the predictive variable (the axis of x) that predicts the probability of an event coded in 0 and 1. In another word what is the probability of an event that occurs based on the independent variable. Let's say what is the probability of a baby surviving (dependent) based on its weight at birth (independent).



## History

The logistic regression test was developed by David Cox and published in 1958 in the Journal of the Royal Statistical Society. Series B (Methodological)
Vol. 20, No. 2 (1958), pp. 215-242. Cox was a statistician from the United Kingdom who was born in 1924 in Birmingham (he is still alive when writing this book). It is recognized by multiple ovations in the area of ​​statistics including stochastic processes and experimental design among many others.  


## An example of an almost perfect logistic regression

In a perfect world you could predict events without error. We create a data set where we have two groups, in the first group (the first ten data of each line) we see that almost all have the binary of "0" apart from one in position nine. In the second group, the values ​​from 10 to 20 in each line all have the value of "1" apart from a data in position 12 of the second line. If it makes it easier for you to think that in the x-axis are the hours that a student is studying for an exam, and the variable "0" and "1" are the consequence, I do not pass (0) / pass the exam (1). We see that the majority of students who study less than 10 hours do not pass the exam and those who study more than 10 hours pass the exam, apart from two students who do not follow the pattern.


```{r, echo = FALSE}
library (ggplot2)
```


```{r perfect logistic regression, echo = TRUE, warning = FALSE}
continuous = c (rep (1: 20.2))
binomial = c (0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,                       
           0,0,0,0,0,0,0,0,0,1,1,0,1,1,1,1,1,1,1,1)
dfLogreg = data.frame (continuous, binomial)
```

### Visualize the logistic regression

To produce the graph you have to use "stat_smooth" with "method =" glm "," glm "means" Generalized Linear Model "(will be explained in the next section), note that you have to indicate the type of data family in the analyzes of "glm", in this case it is "binomial", because we have a response of two alternatives, and finally "se = T" is selected, to have the confidence interval of the curve (the best model). want the confidence interval is added "se = F".  

Typically if one sees a curve, an "S" form, meaning "sigmoid", this is what one expects from a logistic regression where there is a threshold to predict the probability of an event. If the curve does not have a "sigmoid" shape, it is likely that the model (logistic regression) is not a good fit for the data. For example, using the graph the probability threshold to pass or not (50%) is approximately 9.5 hours of study. There are more precise methods to calculate the probability of events that will be discussed later.    

`` `{r}
ggplot (dfLogreg, aes (x = continuous, y = binomial)) +
  geom_point () +
  stat_smooth (method = "glm", method.args = list (family = "binomial"), se = T) 
`` `

## The basic model

For logistic models, we must use the "glm" function found in the "stat" package that is installed automatically when it activates R. The "glm" means "Generalized Linear Model" is a type of analysis that was developed by John Nelder and RWM Wedderburn in 1972 was a method in the early years that saved a lot of computer time for analysis.

The main advantage of the GLM approach is that it linearizes the relationship between the independent variable (fitted value) and the predictive variable using what is called a "link" or a transformation of the data. The type "link" depends on the type of response. In our case, the "link" uses a transformation to convert the binomial response into linear. There are many other types of responses that are not normal or binomial where the GLM method can be very effective, such as data that have Poisson distribution, logNormal, gamma among others. This book will not be discussing these types of analysis.

The basic function is the following, where the logit of the probability of an event is equal to the intercept plus the coefficient * xi. Note that the formula is very similar to a simple regression solmanente that and is the probability of an event.  

$$ logit (p) = {b} _ {0} + {b} _ {1} {x} _ {i} $$
If there is more than one independent variable then the formula is expanded for the other variables, each variable has a coefficient bi. In this case I added a supplementary explanatory variable.  

$$ logit (p) = {b} _ {0} + {b} _ {1} {x} _ {i} + {b} 2 {x} _ {i} $$

The "p" is the probability of the event of interest, that is, the probability of "1" occure. The logistic transformation is defined as the logarithm of the "odds".

$$ odds = \ frac {p} {1-p} = \ frac {the probability \ of the event \ of \ interest} {the probability \ of the absence \ of the \ quad event of interest} $$

and consequently. Note that the results are in the natural logarithm.

$$ logit = ln \ left (\ frac {p} {1-p} \ right) $$


To evaluate if there is a logistic relationship, the function and the following structure of the function are used: "glm (y.binary ~ x.continuous, data = data_data, family = binomial ())".  

We assign a name to our model "logm".  

`` `{r, model logitico}
logm <-glm (binomial ~ continuous, data = dfLogreg, family = binomial ())

summary (logm)
`` `

### Interpretation of the model

The coefficents (b's) are the "Estimates", with the following we have our best line, $ logit (p) = - 8.699 + 0.916 * {x} _ {i} $. The value of p for the variable "continuous" is less than 0.05, suggesting that it is significant and explains at least in part the relationship between the independent and dependent variable. If the coefficient is positive as in this case (b = 0.916) there is a positive relationship between the number of hours a person studies and the probability of passing the test.  

An important concept to understand in logistic regression is the interpretation of the beta coefficients, the "odds ratio", which is what was mentioned above the probability of the events divided over the events that did not occur. If the "odds ratio" is 2, it means that the probability that the event occurs is twice as high when x (x = 0) is present as when x is absent (x = 0).


## The assumptions of the test

It is suggested that the component of the model be evaluated, 1) evaluate how effective the relationship is to explain the independent on the dependent (McFadden's Pseudo R square) and 2) evaluate the proportion of observations that are correctly classified and 3) a third method is the ROC "Receiving Operating Characteristic", which is the second method to evaluate how effective the model is to assign the values ​​to the correct categories.

### Pseudo R ^ 2

This type of R ^ 2 is not interpreted in the same way as a linear regression. There is no R ^ 2 that explains the proportion of the variation of the independent over the dependent for the logistic regression. What is used are similar indexes, in this case the McFadden where it has a range of zero to almost one, where a value of zero suggests that there is no relationship between one variable and the other, and higher the pseudo R2 of McFadden better it is as a predictor (but never reaches zero).

Using the library (pscl) and the pR2 () function, the McFadden R2 is evaluated. The logistic regression is adjusted using the maximum likelihood, in English "maximum likelihood". The pseudo R squared index of McFadden compares the (maximum) likelihood of the model (Lc) with the model that includes only the intercept without covariates (Lnull).

$$ {R} _ {McFadden} ^ {2} = 1- \ frac {log ({L} _ {c})} {log ({L} _ {null})} $$
 

`` `{r}
library (pscl)

pR2 (logm)
`` `


### The proportion of values ​​correctly classified

One way to evaluate how effective the model is is to evaluate whether the proportion of values ​​observed in "1" and "0" are also predicted to be in this same category. We have three steps

1. calculate the probabilities of being in one group or another (see below next section if you want to calculate individual values)
2. assign each one the status of "1" or "0"
3. compare the predicted values ​​to the real values ​​and calculate the average for the whole group.

For our fictitious data group it is observed that 95% of the values ​​are correctly assigned.  




`` `{r}
library (tidyverse)
head (dfLogreg)
probabilities <- logm%>% predict (dfLogreg, type = "response")
predicted.classes <- ifelse (probabilities> 0.5, "1", "0")
mean (predicted.classes == dfLogreg $ binomial)
`` `
Use an example of real data



### ROC curve

The "Receiving Operating Characteristic" ROC is a measure to classify the values ​​and evaluate how effective the method will achieve the classifications. The proportion of the values ​​that were correctly classified and the values ​​that were incorrectly classified in both groups is evaluated. What one observes is the area below the ROC curve. The metric varies from .50 to 1.0 and values ​​above 0.80 indicate that the model is good for discriminating between the two variables of interest.  

`` `{r}
library (pROC)
f1 = roc (binomial ~ continuous, data = dfLogreg) 
f1
plot (f1, col = "network")
`` `


### Predicting the probabilities of a specific event. 

You can predict the probability of any value of Xi using the following formula. 

$$ p = \ frac {exp (b_ {0} + {b} _ {1} * {x} _ {i})} {1 + exp (b_ {0} + {b} _ {1} * { x} _ {i}} $$

So what is the probability of a student passing the exam if he studies 11 hours? 

$$ p = \ frac {exp (-8.699 + 0.916 * 11)} {1 + exp (-8.699 + 0.916 * 11)} $$
The probability is to pass the test is 79.9%. 

`` `{r}
p = exp (-8.699 + 0.916 * 11) / (1 + exp (-8.699 + 0.916 * 11))
p
`` `


In the next example we will be using real dartos to put into practice the above.  

## Karn and Penrose: Weight, gestation period and probability of surviving in bébes. 


### The data

The data come from a study conducted by Mary N. Karn and LS Penrose published in "Annals of Eugenics", entitled "Birth weight and gestation time in relation to maternal age, parity and infant survival" published in 1951. We will be using only a part of the data, specifically the data of male bebes. The gestation period and the weight of the babies were born at birth and their survival. To facilitate the work I have modified the data a bit to fulfill the assigned tasks.

In the file "Karn_Penrose_student" they have data on 7036 birth between the years 1935 and 1946. The file has 4 columns:

1. Line_number = the sequence of the data
2. Gestation_Index = An index of gestation period 
3. Weight_Index = an index of the weight of the baby at birth
4. Surv_Index = The binomial survival rates, 0 = did not survive, 1 = survived. 

The data of "Gestation Index" and "Weight Index" are organized in the deviations from the average. In another word, "0" is the average weight of all babies, a negative value is a value smaller than the average and a positive value is a value greater than the average. An example if for the "Gestation_Index" the value of the baby is zero, then that baby had the average value of approximately 40 weeks of gestation, if for another baby it has -1, it has 40 weeks less a standard deviation below the average.  

The data frame has 4052 data lines (data of 4052 bebes), the minimum weight of a baby at birth was 1 pound and the maximum was 13 pounds, the minimum gestation period was 155 days and the maximum was 345 days.

`` `{r}
library (readr)
Karn_Penrose_infant_survivorship <- read_csv ("~ / Google Drive / Biometry / Biometrics 2017 / Data_FILES / Karn_Penrose_infant_survivorship.csv")
KPdata = Karn_Penrose_infant_survivorship
head (KPdata)
summary (KPdata)
`` `

### The hypotheses

  - Null hypothesis: The weight of the males and the gestation period do not affect the survival rate. 
  
  - Alternative hypothesis # 1: Males with a longer gestation period have a higher probability of survival than males with a greater weight.

  - Alternative hypothesis # 2: Men with higher birth weight have a higher probability of survival than men with a longer gestation period.

### 

`` `{r response variable}
names (KPdata)
str (KPdata)
library (ggplot2)
ggplot (KPdata, aes (Weigth_lb)) +
  geom_histogram (color = "white", fill = "red") +
  labs (X = "Weigth_lb") +
  ggtitle ("Count vs Weigth_lb")

`` `

### Graph the explanatory variables
##to. Gestation period
## b. Weight of males at birth

`` `{r period of gestation}
ggplot (KPdata, aes (Gestation_Time_days)) +
  geom_histogram (fill = "white", color = "red") +
  labs (x = "Gestation Period") +
  ggtitle ("Count vs. Gestation Period")
 
`` `

`` `{r weight-index}
ggplot (KPdata, aes (Survival)) +
  geom_histogram (fill = "white", color = "red") +
  labs (x = "Survival") +
  ggtitle ("Count vs Survival")

`` `


### Question # 4: Using the correct test, evaluate the relationship between survival and:
##to. gestation period
## b. weight of males at birth

`` `{r Period of Gestation and survival}
library (car)
names (KPdata)
modelgest <-glm (Survival ~ Weigth_lb, data = KPdata, family = binomial ())

summary (modelgest)


ggplot (KPdata, aes (x = Weigth_lb, y = Survival)) +
  geom_jitter () +
  stat_smooth (method = "glm", method.args = list (family = "binomial"), se = T) 
`` `




`` `{r}
ggplot (KPdata, aes (x = Gestation_Time_days, y = Survival)) +
  geom_jitter (height = 0.10) +
  stat_smooth (method = "glm", method.args = list (family = "binomial")) +
  geom_smooth (color = "red") +
  geom_smooth (method = lm, color = "yellow") +
  labs (x = "Weight Index", y = "Surv Probability") +
  ggtitle ("Models of Male Survival Probabilities at Birth based on Weight")
`` `

`` `{r Weight-index and survival}
modelweight <- glm (Survival ~ Gestation_Time_days, data = KPdata, family = binomial ())

summary (modelweight)

`` `

Which is the following is the best MODEL? What is a method of choice which can be used quantitatively and less qualitative.  

Compare 3 models

Survival ~ Gestation_Time
Survival ~ Weight
Survival ~ Gestation_Time + Weight

Use the AIC or the AIC, Akaike Information Criterion or with the correction for small sample size.  

From Wikipedia

* The Akaike information criterion (AIC) is an estimator of the relative quality of statistical models for a given set of data. Given a collection of models for the data, AIC estimates the quality of each model, relative to each of the other models. Thus, AIC provides a means for model selection.

AIC is founded on information theory: it offers an estimate of the relative information lost when a given model is used to represent the process that generated the data. (In doing so, it deals with the trade-off between the goodness of fit of the model and the simplicity of the model.)

AIC does not provide a test of a model in the sense of testing a null hypothesis. It tells nothing about the absolute quality of a model, only the quality relative to other models. Thus, if all the candidate models fit poorly, AIC will not give any warning of that. *

https://en.wikipedia.org/wiki/Akaike_information_criterion


## What one reports 
What one reports in an investigation and a publication.



https://stats.idre.ucla.edu/other/mult-pkg/seminars/statistical-writing/


When interpreting the output in the logit metric, "... for a unit change in x, we expect the log to change by k, holding all other variables constant." "This interpretation does not depend on the level of the other variables in the model . "


When interpreting the output in the logit metric, "... for a unit change in x, we expect the log to change by k, holding all other variables constant." "This interpretation does not depend on the level of the other variables in the model . "

When interpreting the output in the metric of odds ratios, "For a unit change in x, the odds are expected to change by a factor of exp (k), holding all other variables constant." "When interpreting the odds ratios, remember that They are multiplicative. This means that positive effects are greater than one and negative effects are between zero and one. Magnitudes of positive and negative effects should be compared by taking the inverse of the negative effect (or vice versa). "" For exp (k)> 1, you could say that the odds are "exp (k) times larger", for exp (k) <1, you could say that the odds are "exp (k) times smaller." "

Now if you are having difficulty understanding a unit change in the log odds really means, and odds ratios are not as clear as you thought, you might want to consider describing your results in the metric of predicted probabilities. Many audiences, and indeed, many researchers, find this to be more intuitive metric in which to understand the results of a logistic regression. While the relationship between the outcome variable and the predictor variables is linear in the logit metric, the relationship is not linear in the probability metric. Remember that "... a constant factor change in the odds does not correspond to a constant change or a constant factor change in the probability. This nonlinearity means that you will have to be precise about the values ​​at which the other variables in the model are held.

I hope that this example makes clear why I say that in order to write to clear and coherent results, you really need to understand the statistical tests that you are running.

Our next example concerns confidence intervals, so let's jump ahead to little bit and talk about confidence intervals in logistic regression output. "If you report the odds ratios instead of the untransformed coefficients, the 95% confidence interval of the odds ratio is typically reported instead of the standard error. The reason is that the odds ratio is a nonlinear transformation of the logit coefficient, so the confidence interval is asymmetric. "
