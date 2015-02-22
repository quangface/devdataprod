library(shiny)

# Define server logic for slider examples
shinyServer(function(input, output) {
  
  nba.df <- read.csv("nba_stats.csv", header = TRUE)
  avght <- round(mean(nba.df$Inches),1)
  avght.ft <- floor(avght/12)
  avght.in <- floor((avght/12-avght.ft)*12)
  avgsal <- round(mean(nba.df$Salary_M),3)
  avgage <- round(mean(nba.df$Age),1)
  avgppg <- round(sum(nba.df$PTS)/sum(nba.df$G),1)
  avgmpg <- round(sum(nba.df$MP)/sum(nba.df$G),1)
  avgfgapg <- round(sum(nba.df$FGA)/sum(nba.df$G),1)
  avgrpg <- round(sum(nba.df$TRB)/sum(nba.df$G),1)
  avgapg <- round(sum(nba.df$AST)/sum(nba.df$G),1)
  
  
  nba1.lm <- lm(Salary_M ~ Inches + Age + MPG + PPG + FGAPG + RPG + APG, data=nba.df)
  
  

  
  # Reactive expression to compose a data frame containing all of
  # the values
  sliderValues <- reactive({
    
    # Compose data frame
    ht.ft <- floor(as.numeric(input$ht)/12)
    ht.in <- (as.numeric(input$ht)/12-floor(as.numeric(input$ht)/12))*12
    data.frame(
      Name = c("Height", 
               "Age",
               "Minutes/g",
               "Points/g",
               "Rebounds/g",
               "Assists/g",
               "Field Goals/g"),
      Value = as.character(c(paste(ht.ft,"-",ht.in), 
                             input$age,
                             input$mpg,
                             input$ppg,
                             input$rpg,
                             input$apg,
                             input$fgapg)), 
      stringsAsFactors=FALSE)
    
    
    
      
  }) 
  

  
  avgvalues <- data.frame(
    Name = c("Height", 
             "Age",
             "Minutes/g",
             "Points/g",
             "Rebounds/g",
             "Assists/g",
             "Field Goals/g",
             "Salary"),
    Value = as.character(c(paste(avght.ft,"-",avght.in), 
                           avgage,
                           avgmpg,
                           avgppg,
                           avgrpg,
                           avgapg,
                           avgfgapg,
                           avgsal)), 
    stringsAsFactors=FALSE)
    
  
  # Show the values using an HTML table
  output$values <- renderTable({
    sliderValues()
  })
  
 
  output$esalary <- renderPrint({ 
    formatC(1000000 * (nba1.lm$coefficients[[1]] + 
      as.numeric(input$ht) * nba1.lm$coefficients[[2]] +
      as.numeric(input$age) * nba1.lm$coefficients[[3]] +
      as.numeric(input$mpg) * nba1.lm$coefficients[[4]] +
      as.numeric(input$ppg) * nba1.lm$coefficients[[5]] +
      as.numeric(input$fgapg) * nba1.lm$coefficients[[6]] +
      as.numeric(input$rpg) * nba1.lm$coefficients[[7]] +
      as.numeric(input$apg) * nba1.lm$coefficients[[8]]), format="d", big.mark=",")
    
    })
  
  output$mytable1 = renderDataTable({
    nba.df[,c(1,2,5,7,9,38,39,40,41,42)]
  }, options = list(aLengthMenu = c(50,100,500), iDisplayLegnth = 50, bSortClasses = TRUE))
  
  # customize the length drop-down menu; display 5 rows per page by default
  output$mytable2 = renderDataTable({
    iris
  }, options = list(aLengthMenu = c(5, 30, 50), iDisplayLength = 5))
  
  output$distPlot <- renderPlot({
    x    <- nba.df[, 7]  
    bins <- seq(min(x), max(x), length.out = 50 + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = 50, col = 'skyblue', border = 'white', xlab = "Salary (in Millions)", 
         main = "Salaires in the NBA")
  })
  
  output$avgPlayer <- renderTable({
    #avgValues()
    data.frame(
      Name = c("Height", 
               "Age",
               "Minutes/g",
               "Points/g",
               "Rebounds/g",
               "Assists/g",
               "Field Goals/g",
               "Salary"),
      Value = as.character(c(paste(avght.ft,"-",avght.in), 
                             avgage,
                             avgmpg,
                             avgppg,
                             avgrpg,
                             avgapg,
                             avgfgapg,
                             formatC(avgsal*1000000, format="d",big.mark=",")), 
      stringsAsFactors=FALSE))
    
  })
  
})