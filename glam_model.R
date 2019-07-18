rm(list=ls(all=TRUE))

remotes::install_github("JohnCoene/g2r")
devtools::install_github("cardiomoon/ggiraphExtra")
library(g2r)
library(ggiraphExtra)

#crabs <- read.table("http://users.stat.ufl.edu/~aa/cat/data/Crabs.dat",
#                    header = TRUE)

setwd("~/Tresors/research/qubes/data")

infants <- read.csv("infant.csv")

names(infants) <- c("id", "survive", "weight", "gestation")

glm(survive ~ weight, binomial)

library(g2r)

g2(infants, asp(survive, weight, gestation)) %>%
  fig_point() %>%
  fig_smooth() %>%
  fig_smooth(method = loess)

fit1 <- lm(survive ~ weight + gestation, data = infants)

fit2 <- glm(survive ~ weight + gestation, data = infants, 
            family = binomial)

fit3 <- loess(survive ~ weight * gestation, data = infants)


ggPredict(fit1, se=TRUE, interactive = TRUE, digits = 3)
ggPredict(fit2, se=TRUE, interactive = TRUE, digits = 3)

ggPredict(fit3, se=TRUE, interactive = TRUE, digits = 3)


g2(infants, asp(weight, gestation, color = survive)) %>% 
  fig_point()

g2(infants, asp(weight, gestation, color = survive, size = weight)) %>% 
  fig_point() %>% 
  gauge_color(c("blue", "white", "red"))

infants %>%
  g2(asp(weight, gestation, color = survive)) %>% 
  fig_point() %>%
  plane_wrap(planes(survive), type = "tree")
