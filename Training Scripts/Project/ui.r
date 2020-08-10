shinyUI(
  
  navbarPage("Amazon fires",
    tabPanel("Dynamic",
      
      tags$img(src="brazil.png", style = 'position: absolute; opacity:0.2; width: 100%'),
      
      sidebarPanel(
        selectInput("variable", "Please select the chart type:",
                    list("Total summary" = "state", 
                         "By Month" = "month", 
                         "By Year" = "year")),
        
          conditionalPanel(condition = "input.variable == 'year'",
                           sliderInput("year_int", "Please select Year:",
                                       min=1998, max=2017, value=2010, step=1, sep="")),
    
          
          conditionalPanel(condition = "input.variable == 'month'",
                          selectInput("month_str", "Please select month:",
                                     list("January" = "January",
                                     "February" = "February",
                                     "March" = "March",
                                     "April" = "April",
                                     "May" = "May",
                                     "June" = "June",
                                     "July" = "July",
                                     "August" = "August",
                                     "September" = "September",
                                     "October" = "October",
                                     "November" = "November",
                                     "December" = "December"))),     
        
        
        mainPanel(
          plotOutput("myPlot", width="auto")
        )),
      ),
  
  tabPanel("Static",
           
           tags$img(src="brazil.png", style = 'position: absolute; opacity:0.20; width: 100%'),
           
           sidebarPanel(
             selectInput("type", "Please select the chart type:",
                         list("Years" = "year", 
                              "States" = "state",
                              "Months" = "month",
                              "Histogram" = "hist",
                              "Regression" = "regr")),
             
             ),
           mainPanel(
             plotOutput("staticPlot")
           )
    )
  )
)


