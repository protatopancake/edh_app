#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            
            # Input: Select a file ----
            fileInput("file1", "Choose Deck File",
                      multiple = TRUE,
                      accept = c("text/csv",
                                 "text/comma-separated-values,text/plain",
                                 ".csv",
                                 ".txt")),
            
            # Horizontal line ----
            tags$hr(),
            
            # Input: Select User ----
            radioButtons("user", "User",
                         choices = c(Alex = "Alex",
                                     Nick = "Nick",
                                     Tom = "Tom",
                                     Cam = "Cam")
                         ),
            
            # Input: Select Date ----
            dateInput("deck_date", "Date",
                      value= Sys.Date()),
            
            # Horizontal line ----
            tags$hr(),
            
            # Input: Select number of rows to display ----
            radioButtons("disp", "Display",
                         choices = c(Head = "head",
                                     All = "all"),
                         selected = "head")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            tableOutput("upload")
        )
    )
))
