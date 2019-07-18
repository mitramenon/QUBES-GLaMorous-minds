library(shiny)
library(ggplot2)

birth<-read.csv("Karn_Penrose_Infant_Survivorship_QUBES.csv",stringsAsFactors = F)

ui <- fluidPage(
  titlePanel("GLM app"),
  sidebarLayout(
    sidebarPanel(sliderInput("Weight_lb", "Wt(lb)", min = 0, max = 13,
                             value = c(5, 10)), 
                 selectInput("variable", "choose a variable:", c("Survival","Weigth_lb","Gestation_Time_days")),
                 selectInput("predictor", "pick predictor:", c("Survival","Weigth_lb","Gestation_Time_days")),
    selectInput("response", "pick response:", c("Survival","Weigth_lb","Gestation_Time_days")),
    selectInput("Model", "pick model:", c("logistic(binary)","linear(continous)","Poisson(counts)"))),
    mainPanel(plotOutput("coolplot"),
              br(),
              plotOutput("plot1", click = "plot_click")
              )
  )
  
)

server <- function(input, output) {
  
  output$coolplot <- renderPlot({
   x <- input$variable
   ggplot(birth, aes(x=birth[ ,x])) + 
     geom_histogram(color="black", fill="firebrick")})
  
    output$plot1 <- renderPlot({
      PR<-input$predictor
      RS<-input$response
      ggplot (birth, aes (x = birth[ ,PR], y = birth[ ,RS])) + 
        geom_jitter (height = 0.10) +
        geom_smooth (method = lm, color = "yellow") + 
        stat_smooth (method = "glm", method.args = list (family = "binomial"))+
        labs (x = "Weight Index", y = "Surv Probability") +
        ggtitle ("Models of Male Survival Probabilities at Birth based on Weight")})
}

shinyApp(ui = ui, server = server)