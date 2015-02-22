library(shiny)
library(ggplot2)

# Define UI for slider demo application
shinyUI(fluidPage(
  
  #  Application title
  titlePanel("NBA Salary Estimator"),
  
  # Sidebar with sliders that demonstrate various available
  # options
  
  #nba1.lm <- lm(Salary_M ~ Inches + Age + MPG + PPG + FGAPG + RPG + APG, data=nba.df)
  
  
  sidebarLayout(
    sidebarPanel(
      # Simple integer interval
      #sliderInput("ht3", "Height:", 
       #           min=1, max=120, value=72),
      
      #ht
      selectInput("ht", "Height (ft-in)", 
                  choices = list("5-0" = 60, 
                                 "5-1" = 61, 
                                 "5-2" = 62, 
                                 "5-3" = 63, 
                                 "5-4" = 64, 
                                 "5-5" = 65, 
                                 "5-6" = 66, 
                                 "5-7" = 67, 
                                 "5-8" = 68, 
                                 "5-9" = 69, 
                                 "5-10" = 70, 
                                 "5-11" = 71,                                 
                                 "6-0" = 72, 
                                 "6-1" = 73, 
                                 "6-2" = 74, 
                                 "6-3" = 75, 
                                 "6-4" = 76, 
                                 "6-5" = 77, 
                                 "6-6" = 78, 
                                 "6-7" = 79, 
                                 "6-8" = 80, 
                                 "6-9" = 81, 
                                 "6-10" = 82, 
                                 "6-11" = 83,
                                 "7-0" = 84, 
                                 "7-1" = 85, 
                                 "7-2" = 86, 
                                 "7-3" = 87, 
                                 "7-4" = 88, 
                                 "7-5" = 89, 
                                 "7-6" = 90, 
                                 "7-7" = 91, 
                                 "7-8" = 92, 
                                 "7-9" = 93, 
                                 "7-10" = 94, 
                                 "7-11" = 95,
                                 "8-0" = 96, 
                                 "8-1" = 97, 
                                 "8-2" = 98, 
                                 "8-3" = 99, 
                                 "8-4" = 100, 
                                 "8-5" = 101, 
                                 "8-6" = 102, 
                                 "8-7" = 103, 
                                 "8-8" = 104, 
                                 "8-9" = 105, 
                                 "8-10" = 106, 
                                 "8-11" = 107, 
                                 "9-0" = 108),
                  selected = 65),      

      
      # Decimal interval with step value
      sliderInput("age", "Age:", 
                  min = 0, max = 100, value = 25, step= 0.25),
      
      # Decimal interval with step value
      sliderInput("mpg", "Minutes per game:", 
                  min = 0, max = 50, value = 30, step= 0.1),
      
      # Decimal interval with step value
      sliderInput("ppg", "Points per game:", 
                  min = 0, max = 100, value = 20, step= 0.1),
      
      # Decimal interval with step value
      sliderInput("rpg", "Rebounds per Game:", 
                  min = 0, max = 50, value = 6, step= 0.1),
      
      # Decimal interval with step value
      sliderInput("apg", "Assists per Game:", 
                  min = 0, max = 50, value = 5, step= 0.1),
      
      
      # Decimal interval with step value
      sliderInput("fgapg", "Shot Attempts per Game:", 
                  min = 0, max = 100, value = 20, step= 0.1)
      
     #submitButton("Submit")
    ),
    
    # Show a table summarizing the values entered
    mainPanel(
      
      tabsetPanel(
        tabPanel('Intro', 
                h2("Welcome to the NBA Salary Estimator"),
                img(src="18_john_wall.jpg", height = 330, width = 600),
                br(),
                h4("This app will help you determine a projected NBA Salary given certain metrics.
                    We analyzed this season's player's statistics and came up with a model to estimate a player's 
                    salary given their height, age and various other per game statistics."),
                br(),
                h4("All player stats and salary information was sourced from: ",
                   a("basketball-reference.com", href="http://www.basketball-reference.com"))
                 ),    
        tabPanel('Salary Estimator',
                 p("Your Inputs:"),
                 tableOutput("values"),
                 h1("Expected Salary ($): "),
                 textOutput("esalary")
                 ),
        tabPanel('Player Data',
                 dataTableOutput("mytable1")),
        tabPanel('Salary Distribution',
                 plotOutput("distPlot")),
        tabPanel('Avg Player',
                 tableOutput("avgPlayer"))
        )
      
      
      
      
    )
  )
))