# Describe the dataset


# The Karn and Penrose Data set*
This data set are from Mary N. Karn and L. S. Penrose published in the “Annals of Eugenics” titled "Birth Weight and gestation time in relation to maternal age, parity and infant survival"  published in 1951.  
The data represent the survivorship of male babies within the first week of birth based on the weight and time of gestation.  
The file contains contiens 4051 babies from the years 1935 y 1946. The file has 4 columns: 

1.	Line_number
2.	Gestation_Time_days;  Gestation time from day of conception to day of birth
3.	Weight_lb; the weight of the babies in pounds
4.	Survival: babies survived “1” or died “0”.  


The first step is making a choice for the appropriate GLM model. This requires evaluating the type of response variables.

The reponse variables can have different shape


1. Normal distribution (Gaussian distribution)
    - this is the basic bell shape curve

2. Binomial (only two alternives)
    - alive or dead
    - Yes or No
    
 3. Poisson Distribution
    - These are counts (thus no partial values)
      -- Plants have 0, 1, 2 4, fruits (but they cannot have 1.5 fruit)
      
 4. There are also other types of distributions which will not discuss these at this moment. 
    - Inverse Normal, logit function, logit, probit, multinomialprobit, Ordered logit, identity, variance and others. 
      
# Second Step

Thus you need to graph the response variable to decide which of these       
      




```
birth<-read.csv("Karn_Penrose_Infant_Survivorship_QUBES.csv")
head(birth)
summary(birth)
```
