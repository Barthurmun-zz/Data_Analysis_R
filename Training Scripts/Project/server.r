library(shiny)
library(shinyWidgets)
require(data.table)
require(ggplot2)
require(dplyr)
require(readr)
require(tidyverse)
require(knitr)
require(readr)
require(lubridate)
require(brazilmaps)
require(sf)
require(maptools)

source("functions.R")

rm(list = ls())

data <- read.csv("amazon.csv") %>% mutate(date=as.Date(date))
data_year <- aggregate(list(number_of_fires=data$number), by=list(sum_year=data$year), FUN=sum)

data_state <- aggregate(list(number_of_fires=data$number), by=list(sum_state=data$state), FUN=sum)

data_month <- aggregate(list(number_of_fires=data$number), by=list(sum_month=data$month), FUN=sum)
data_month$sum_month <- factor(data_month$sum_month, levels = month.name)

states_map <- get_brmap(geo = "State",
                        geo.filter = NULL,
                        class = "sf") %>% arrange(nome)

shinyServer(
  function(input,output){
    
     output$myPlot <- renderPlot({
        
       if(input$variable == "state") {
          states_map$number_of_fires <- data_state$number_of_fires
          plot_custom_map(states_map)
        }

       else if(input$variable == "year") {
         yearly_data <- data[data$year==input$year_int,]
         yearly_data_agg <- aggregate(list(number_of_fires=yearly_data$number), by=list(sum_state=yearly_data$state), FUN=sum)
         states_map$number_of_fires <- yearly_data_agg$number_of_fires
         plot_custom_map(states_map)
          
       }
       
       else if(input$variable == "month") {
         monthly_data <- data[data$month==input$month_str,]
         monthly_data_agg <- aggregate(list(number_of_fires=monthly_data$number), by=list(sum_state=monthly_data$state), FUN=sum)
         states_map$number_of_fires <- monthly_data_agg$number_of_fires
         plot_custom_map(states_map)
         
       }
      
    }, bg="transparent")
     
     output$staticPlot <- renderPlot({
       
       if(input$type == "year") {
         ggplot(data = data_year, aes(x=sum_year, y=number_of_fires)) + geom_bar(stat = "identity", alpha=I(0.2)) + labs(x = 'Year', y = "Number of fires")
       }
       
       else if(input$type == "state") {
         ggplot(data = data_state, aes(x=sum_state, y=number_of_fires)) + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 90)) + labs(x = 'State', y = "Number of fires")
       }
       
       else if(input$type == "month") {
         data_month %>% arrange(sum_month) %>% ggplot(data = . , aes(x=sum_month, y=number_of_fires)) + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 90)) + labs(x = 'Month', y = "Number of fires")
       }
       
       else if(input$type == "hist") {
         ggplot(data = data, aes(x=number, fill=`month`)) + geom_histogram() + labs(x = 'Number of fires', y = "Number of samples", fill = "Month")
       }
       
       else if(input$type == "regr") {
         ggplot(data = data_year, aes(x=sum_year, y=number_of_fires)) + geom_point() + geom_line()+ stat_smooth(method = 'lm') + labs(x = 'Year', y = "Number of fires")
       }
     }, bg="transparent")
     
})