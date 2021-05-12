# Modified from https://shiny.rstudio.com/tutorial/written-tutorial/lesson1/

library(shiny)
data(cars)

# Define UI for app that draws a histogram
ui = fluidPage(
  
  # We can give App title under the titlePanel 
  titlePanel("Cars"),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    
    # Sidebar panel for inputs 
    sidebarPanel(
      
      # Input: Slider for the number of bins
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
      
    ),
    
    # Main panel for displaying Outputs
    mainPanel(
      
      # Output: Histogram of dist
      plotOutput(outputId = "distPlot")
      
    )
  )
)

# Define server logic required to draw a histogram ----
server = function(input, output) {
  
  
  output$distPlot = renderPlot({
    
    x    = cars$dist
    x    = na.omit(x)  # if any missing values are present the it will omit
    bins = seq(min(x), max(x), length.out = input$bins + 1) 
    
    hist(x, breaks = bins, col = "green", border = "black",
         xlab = "Dist",
         main = "Histogram of Distance")
    
  })
  
}

# Final Step will execute the Shiny app 
shinyApp(ui, server)