#Logistic regression model

# Explore your data through a histogram and determine if the data is binary and appropriate for logistic regression

La regresión logística es una regresión especial donde la variable predictiva (en el eje de x) es una variable continua, y la variable de respuesta tiene solamente dos alternativas. Las alternativas tipicamente se codifican como 0 o 1, pero tambien se puede codificar como vivo/muerto; presente/auscente; saludable/no saludable; gano/perdio; paso/no paso son alternativas entre otras.

Existe tambien otros tipos de regresión logística como la multinomial (múltiples grupos) y extenciones más complejas, pero de estos tipos no lo vamos a cubrir en este libro. 

El objetivo de una regressión logistica es modelar la probabilidad de un evento basado en una variable independiente y determinar si un "threshold" o sea un umbral en la variable predictiva (el eje de x) que predice la probabilidad de un evento codificado en 0 y 1.  En otra palabra cual es la probabilidad de un evento que occure basado en la variable independiente.  Digamos cual es la probabilidad de un bebe sobrevivir (dependiente) basado en su peso al nacer (independiente).



## Historia

La prueba de regresión logistica fue desarollado por David Cox y publicado en 1958 en Journal of the Royal Statistical Society. Series B (Methodological)
Vol. 20, No. 2 (1958), pp. 215-242.  Cox fue un estadístico del Reino Unido que nacio en 1924 en Birmingham (sigue vivo al escribir este libro). Es reconocido por múltiples oportaciones en el área de la estadística incluyendo procesos estocásticos y diseño experimentales entre muchos otras.  


## Un ejemplo de una regresión logística casi perfecta

En un mundo perfecto se podría predicir los eventos sin error.  Creamos un set de datos donde tenemos dos grupos, en el primer grupo (los primeros diez datos de cada linea) vemos que casi todos tienen la binario de "0" aparte de uno en la posición nueve.  En el segundo grupo, los valores del 10 al 20 en cada linea todos tienen el valor de "1" aparte de un dato en la posición 12 de la segunda linea.  Si le hace más facil piensan que en el eje de x son la horas que un estudiante estudio para un examen, y la variable "0" y "1" son la consecuencia, no paso(0)/paso el examen(1).  Vemos que la mayoria de los estudiantes que estudian menos de 10 horas no pasan el examen y los que estudian más de 10 horas pasan el examen, aparte de dos estudiantes que no siguen el patrón. 


```{r, echo=FALSE}
library(ggplot2)
```


```{r perfect logistic regression, echo=TRUE, warning=FALSE}
continuo=c(rep(1:20,2))
binomial=c(0,0,0,0,0,0,0,1,0,1,1,1,1,1,1,1,1,1,1,1,                       
           0,0,0,0,0,0,0,0,0,1,1,0,1,1,1,1,1,1,1,1)
dfLogreg=data.frame(continuo,binomial)
```

### Visualizar la regresión logística

Para producir el gráfico hay que utilizar "stat_smooth" con "method="glm", "glm" significa "Generalized Linear Model" (se explicará en la proxima sección), nota que hay que indicar el tipo de familia de datos en los analisis de "glm", en este caso es "binomial", por que tenemos una repuesta de dos alternativas, y por ultimo se seleciona "se=T", para tener el intervalo de confianza de la curva (el mejor modelo). Si no quiere el intervalo de confianza se añade "se=F".  

Tipicamente si uno ve una curva un forma de "S" o sea "sigmoid" es lo que uno espera de una regresión logística donde hay un umbral (threshold), para predecir la probabilidad de un evento.  Si la curva no tiene una forma "sigmoid" es probable que el modelo (la regresión logística) no es un buen ajuste para los datos.  Por ejemplo, usando el gráfico el umbral de probabilidad de pasar o no (50%) es aproximadamente 9.5 horas de estudio. Hay metodos más precisos para calcular las probabilidad de eventos que se discutaran más adelante.    

```{r}
ggplot(dfLogreg, aes(x=continuo, y=binomial)) +
  geom_point() +
  stat_smooth(method="glm", method.args = list(family = "binomial"), se=T) 
```

## El modelo básico

Para los modelos logísticos hay que utilizar la función "glm" que se encuentra en el package "stat" que se instala automaticamente cuando activa R. El "glm" significa "Generalized Linear Model" es un tipo de analisis que fue desarollado por John Nelder and R.W.M. Wedderburn in 1972 era un metodo en los primeros años que salvo mucho tiempo de computadora para hacer analisis. 

La ventaja principal del acercamiente de GLM es que lineariza la relación entre la variable independiente (fitted value) y la predictiva usando lo que se llama un "link" o sea una transformación de los datos. El tipo "link" depende del tipo de repuesta.  En nuestro caso el "link", usa una transformación para convertir la repuesta binomial en lineal.  Hay muchos otros tipos de repuestas que no son normal o binomial donde el metodo de GLM puede ser muy efectivo, como datos que tienen distribución Poisson, logNormal, gamma entre otros.  Este libro no estaremos discutiendo estos tipos de analisis.

La función básica es lo siguiente, donde el logit de la probabilidad de un evento es igual al intercepto más el coefficiento * xi.  Notan que la formula es muy similar a una regresión simple solmanente que la y es la probabilidad de un evento.  

$$logit(p)={ b }_{ 0 }+{ b }_{ 1 }{ x }_{ i }$$
Si hay más de una variable independiente entonces se expande la formula para las otras variables, cada variable tiene un coefficiente bi. En este caso añadi una variable explicativa suplementaria.  

$$logit(p)={ b }_{ 0 }+{ b }_{ 1 }{ x }_{ i }+{ b }_{ 2 }{ x }_{ i }$$

La "p" es la probabilidad del evento de interes, o sea la probabilidad de "1" occure.  La transformation logística se defina como el logaritmo de los "odds".

$$odds=\frac { p }{ 1-p } =\frac { la\quad probabilidad\quad del\quad evento\quad de\quad interes }{ la\quad probabilidad\quad del\quad ausencia\quad del\quad evento\quad de\quad interes }$$

y por consecuencia.  Nota que los resultados estan en el logaritmo natural.

$$logit=ln\left( \frac { p }{ 1-p }  \right)$$


Para evaluar si hay una relación logística se usa la función y la siguiente estructura de la función: "glm(y.binaria~x.continua, data=los_datos, family=binomial())".  

La asignamos un nombre a nuestro modelo "logm".  

```{r, model logitico}
logm<-glm(binomial~continuo, data= dfLogreg, family = binomial())

summary(logm)
```

### Interpretación del modelo

Los coefficents (b's) son los "Estimates", con lo siguiente tenemos nuestra mejor linea, $logit(p)=-8.699+0.916*{ x }_{ i }$. El valor de p para la variable "continuo" es menor de 0.05, sugeriendo que es significativo y explica por lo menos en parte la relación entre la variable independiente y dependiente. Si el coefficiente es positivo como en este caso (b = 0.916) hay una relación positiva entre la cantidad de horas que estudia una persona y la probabilidad de pasar el examen.  

Un concepto importante intender en regresión logistica es la intepretación de los coeficientes beta, los "odds ratio", que es lo que se mencionó anteriomente la probabilidad de los eventos dividido sobre los eventos que no ocurieron. Si el "odds ratio" es de 2 significa que la probabildad que el evento occure es dos veces más alto cuando x (x=0) esta presente que cuando x este auscente (x=0). 


## Los supuestos de la prueba

Se sugiere que se evalué do componente del modelo, 1) evaluar cuan efectiva es la relación para explicar la independiente sobre la dependiente (Pseudo R cuadrado de McFadden) y 2) evaluar la proporción de observaciones que son corectamente clasificado y 3) un tercer metodo es el ROC "Receiving Operating Characteristic", que es segundo metodo de evaluar cuan efectivo el modelo es a asignar los valores a las categorias corecta.

### Pseudo R^2

Este tipo de R^2 no se interpreta de la misma manera que una regresión lineal. No hay R^2 que explica la proporción de la variación de la independiente sobre la dependiente para la regresión logística. Lo que se usa son indice similares, en este caso el de McFadden donde tiene un rango de cero a casi uno, donde un valor de cero suguiere que no hay relación entre una variable y la otra, y más alto el pseudo R2 de McFadden mejor es como predictor (pero nunca llega a cero). 

Usando la library(pscl) y la función pR2( ) se evalua el R2 de McFadden. La regressión logistica se ajusta usando la máxima verosimilitud, en ingles "maximum likelihood". El indice de pseudo R cuadrado de McFadden compara la verosimilitud (máximo) del modelo (Lc) con el modelo que incluye solamente el intercepto sin covariantes (Lnull). 

$${ R }_{ McFadden }^{ 2 }=1-\frac { log({ L }_{ c }) }{ log({ L }_{ null }) }$$
 

```{r}
library(pscl)

pR2(logm)
```


### La proporción de valores clasificados corectamente

Una manera de evaluar cuan efectivo es el modelo es evaluar si la proporción de valores observado en "1" y "0" son tambien predecido a estar en esta misma categoria. Tenemos tres pasos

1. calcular la probabilidades de estar en un grupo o otro (vea abajo proxima sección si quiere calcular valores individuales)
2. asignar a cada uno el estado de "1" o "0"
3. comparar los valores predecido a los valores reales y calcular el promedio para todo el grupo.

Para nuestro grupo de datos ficticio lo que se observa que 95% de los valores estan corectamente asignados.  




```{r}
library(tidyverse)
head(dfLogreg)
probabilities <- logm %>% predict(dfLogreg, type = "response")
predicted.classes <- ifelse(probabilities > 0.5, "1", "0")
mean(predicted.classes==dfLogreg$binomial)
```
Usar un ejemplo de datos reales



### ROC curve

El "Receiving Operating Characteristic" ROC es una medida de clasificar los valores y evaluar cuan efectivo el metodo lográ las clasificaciones.  Se evalua la proporción de los valores que fueron corectamente clasificado y los valores que fueron incorectamente clasificados en ambos grupos. Lo que uno observa es el area debajo la curva de ROC. La metrica varia de .50 a 1.0 y valores por encima de 0.80 indica que el modelo es bueno para descriminar entre las dos variables de interes.  

```{r}
library(pROC)
f1 = roc(binomial ~ continuo, data=dfLogreg) 
f1
plot(f1, col="red")
```


### Predicir la probabilidades de un evento especifico. 

Se puede predecir la probabilidad de cualquier valor de Xi usando la formula siguiente. 

$$p=\frac { exp(b_{ 0 }+{ b }_{ 1 }*{ x }_{ i }) }{ 1+exp(b_{ 0 }+{ b }_{ 1 }*{ x }_{ i }) } $$

Entonces cual es la probabilidad de un estudiante pasar el examen si estudia 11 horas. 

$$p=\frac { exp(-8.699+0.916*11) }{ 1+exp(-8.699+0.916*11) }$$
La probabilidad es de pasar el examen es de 79.9%. 

```{r}
p=exp(-8.699+0.916*11)/(1+exp(-8.699+0.916*11))
p
```


En el proximo ejemplo estaremos utilizando dartos reales para poner en practica lo anterior.  

##  Karn and Penrose: El peso, periodo de gestación y probabilidad de sobrevivir en bébes. 


### Los Datos

Los datos provienen de un estudio realizado por Mary N. Karn and L. S. Penrose publicado en "Annals of Eugenics", titulado "Birth weight and gestation time in relation to maternal age, parity and infant survival" publicado en 1951.  Estaremos usando solamente una parte de los datos, specificamente los datos de los bébes varones. El periodo de gestación y el peso de los bebés varon al nacer y su supervivencia.  Para faciltar el trabajo he modificado los datos un poco para cumplir con las tareas asignada.

En el archivo "Karn_Penrose_student" tienen datos sobre 7036 nacimiento entre los años 1935 y 1946. El archivo tiene 4 columnas:

1. Line_number = la secuencia de los datos
2. Gestation_Index =  Un indice de periodo de gestación 
3. Weight_Index = un indice del peso del bébe al nacer
4. Surv_Index = El indices de supervivencia binomial, 0 = no sobrevivió, 1 = sobrevivió. 

Los datos de "Gestation Index" y "Weight Index" estan organizado en las desviacion del promedio.  En otra palabra el "0" equivale al peso promedio de todos los bebés, un valor negativo son valores más pequeño que el promedio y un valor positivo es un valor más grande que el promedio.   Un ejemplo si para el "Gestation_Index" el valor del bebe es cero, entonces ese bebe tenia el valor promedio de aproximadamente 40 semanas de gestación, si para otro bebé tiene -1, tiene 40 semanas menos una desviación estandar por debajo el promedio.  

El data frame tiene 4052 lineas de datos (datos de 4052 bébes), el peso minimo de un bebe al nacer fue 1 libra y al maximo fue 13 libras, el periodo de gestación minimo fue de 155 dias y el maximo fue de 345 dias.

```{r}
library(readr)
Karn_Penrose_infant_survivorship <- read_csv("~/Google Drive/Biometry/Biometria 2017/Data_FILES/Karn_Penrose_infant_survivorship.csv")
KPdata=Karn_Penrose_infant_survivorship
head(KPdata)
summary(KPdata)
```

### Las hipotesis

  - Hipotesis Nula: El peso de los varones y el periodo de gestacion no afectan el indice de supervivencia. 
  
  - Hipotesis alterna #1: Los varones con un periodo de  mayor gestacion tienen mayor probabilidad de supervivencia que los varones con un mayor peso.

  - Hipotesis alterna #2: Los varones con mayor peso al nacer tienen mayor probabilidad de supervivencia que los varones con un mayor periodo de gestacion.

### 

```{r variable de respuesta}
names(KPdata)
str(KPdata)
library(ggplot2)
ggplot(KPdata, aes(Weigth_lb))+
  geom_histogram(colour="white", fill="red")+
  labs(X = "Weigth_lb")+
  ggtitle("Count vs Weigth_lb")

```

### Haga una grafica de las variables explicativas
##a. Periodo de gestación
##b. Peso de los varones al nacer

```{r periodo de gestacion}
ggplot(KPdata, aes(Gestation_Time_days))+
  geom_histogram(fill="white", colour="red")+
  labs(x= "Gestation Period")+
  ggtitle("Count vs Gestation Period")
 
```

```{r weight-index}
ggplot(KPdata,aes(Survival))+
  geom_histogram(fill="white", colour="red")+
  labs(x="Survival")+
  ggtitle("Count vs Survival")

```


### Pregunta #4: Usando la prueba correcta evalua la relacion entre la supervivencia y:
##a. periodo de gestacion
##b. peso de los varones al nacer

```{r Periodo de Gestacion y supervivencia}
library(car)
names(KPdata)
modelgest<-glm(Survival~Weigth_lb, data= KPdata, family = binomial())

summary(modelgest)


ggplot(KPdata, aes(x=Weigth_lb, y=Survival)) +
  geom_jitter() +
  stat_smooth( method="glm", method.args = list(family = "binomial"), se=T) 
```




```{r}
ggplot(KPdata, aes(x=Gestation_Time_days, y=Survival)) +
  geom_jitter(height=0.10) +
  stat_smooth( method="glm", method.args = list(family = "binomial")) +
  geom_smooth(color="red")+
  geom_smooth(method = lm, color="yellow")+
  labs(x= "Weight Index", y= "Surv Probability")+
  ggtitle("Models of Male Survival Probabilities at Birth based on Weight")
```

```{r Weight-index y supervivencia}
modelweight<- glm(Survival~Gestation_Time_days, data = KPdata, family = binomial())

summary(modelweight)

```

Which is the following is the best MODEL?  What is a method of choice which can be used that can be more quantitative and less qualitative.  

Compare 3 models

Survival~Gestation_Time
Survival~Weight
Survival~Gestation_Time+Weight

Use the AIC or the AIC, Akaike Information Criterion or  with the correction for small sample size.  

From Wikipedia

*The Akaike information criterion (AIC) is an estimator of the relative quality of statistical models for a given set of data. Given a collection of models for the data, AIC estimates the quality of each model, relative to each of the other models. Thus, AIC provides a means for model selection.

AIC is founded on information theory: it offers an estimate of the relative information lost when a given model is used to represent the process that generated the data. (In doing so, it deals with the trade-off between the goodness of fit of the model and the simplicity of the model.)

AIC does not provide a test of a model in the sense of testing a null hypothesis. It tells nothing about the absolute quality of a model, only the quality relative to other models. Thus, if all the candidate models fit poorly, AIC will not give any warning of that.*

https://en.wikipedia.org/wiki/Akaike_information_criterion


## Lo que uno reporta 
Lo que uno reporta en una investigación y una publicación.



https://stats.idre.ucla.edu/other/mult-pkg/seminars/statistical-writing/


When interpreting the output in the logit metric, “… for a unit change in xk, we expect the logit to change by k, holding all other variables constant.”  “This interpretation does not depend on the level of the other variables in the model.”


When interpreting the output in the logit metric, “… for a unit change in xk, we expect the logit to change by k, holding all other variables constant.”  “This interpretation does not depend on the level of the other variables in the model.”

When interpreting the output in the metric of odds ratios, “For a unit change in xk, the odds are expected to change by a factor of exp(k), holding all other variables constant.”  “When interpreting the odds ratios, remember that they are multiplicative.  This means that positive effects are greater than one and negative effects are between zero and one. Magnitudes of positive and negative effects should be compared by taking the inverse of the negative effect (or vice versa).”  “For exp(k) > 1, you could say that the odds are “exp(k) times larger”, for exp(k) < 1, you could say that the odds are “exp(k) times smaller.””

Now if you are having difficulty understanding a unit change in the log odds really means, and odds ratios aren’t as clear as you thought, you might want to consider describing your results in the metric of predicted probabilities. Many audiences, and indeed, many researchers, find this to be a more intuitive metric in which to understand the results of a logistic regression.  While the relationship between the outcome variable and the predictor variables is linear in the logit metric, the relationship is not linear in the probability metric.  Remember that “… a constant factor change in the odds does not correspond to a constant change or a constant factor change in the probability.  This nonlinearity means that you will have to be very precise about the values at which the other variables in the model are held.

I hope that this example makes clear why I say that in order to write a clear and coherent results section, you really need to understand the statistical tests that you are running.

Our next example concerns confidence intervals, so let’s jump ahead a little bit and talk about confidence intervals in logistic regression output.  “If you report the odds ratios instead of the untransformed coefficients, the 95% confidence interval of the odds ratio is typically reported instead of the standard error.  The reason is that the odds ratio is a nonlinear transformation of the logit coefficient, so the confidence interval is asymmetric.”
