#Describe the dataset


#*The Karn and Penrose Data set*
This data set are from Mary N. Karn and L. S. Penrose published in the “Annals of Eugenics” titled "Birth Weight and gestation time in relation to maternal age, parity and infant survival"  published in 1951.  
The data represent the survivorship of male babies within the first week of birth based on the weight and time of gestation.  
The file contains contiens 4051 babies from the years 1935 y 1946. The file has 4 columns: 

1.	Line_number
2.	Gestation_Time_days;  Gestation time from day of conception to day of birth
3.	Weight_lb; the weight of the babies in pounds
4.	Survival: babies survived “1” or died “0”.  


The steps to making a choice for the appropriate GLM models requires evaluating the type of response variables. 




```
birth<-read.csv("Karn_Penrose_Infant_Survivorship_QUBES.csv")
head(birth)
summary(birth)
```
