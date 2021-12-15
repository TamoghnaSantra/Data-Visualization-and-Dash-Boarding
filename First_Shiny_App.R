library(shiny)
library(tidyverse)

#####Import Data

dat<-read_csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1"))
dat<- dat %>% select(c("pid7","ideo5"))
dat<-drop_na(dat)

ui <- fluidPage(
  
  titlePanel("My First Shiny App"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("ideology",
                  "Select Five Point Ideology (1=Very liberal, 5=Very conservative)",
                  min = 1,
                  max = 5,
                  value = 3)
      ),
    mainPanel(
      plotOutput(outputId = "barPlot")
    )
    )
  )
  

server<-function(input,output){
  output$barPlot <- renderPlot({
    ggplot(
      filter(dat, ideo5 == input$ideology),
      aes(x=pid7))+
      geom_bar()+
      xlab("Seven Point Party ID, 1 - Very D, 7 - Very R")+
      ylab("Count")
  })
}

shinyApp(ui=ui,server=server)
