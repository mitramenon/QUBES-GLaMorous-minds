# Describe the dataset


# *The Karn and Penrose Data set*
This data set are from Mary N. Karn and L. S. Penrose published in the “Annals of Eugenics” titled "Birth Weight and gestation time in relation to maternal age, parity and infant survival"  published in 1951.  
The data represent the survivorship of male babies within the first week of birth based on the weight and time of gestation.  
The file contains contiens 4051 babies from the years 1935 y 1946. The file has 4 columns: 

1.	Line_number
2.	Gestation_Time_days;  Gestation time from day of conception to day of birth
3.	Weight_lb; the weight of the babies in pounds
4.	Survival: el bebe sobrevivio “1”o no “0”

```
birth<-read.csv("Karn_Penrose_Infant_Survivorship_QUBES.csv")
head(birth)
summary(birth)
```

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
 
 
