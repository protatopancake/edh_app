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
    titlePanel("暴力団 (bōryokudan) Commander League"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
<<<<<<< HEAD
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            
            # Input: Select a file ----
            fileInput("file1", "Choose Deck File",
                      multiple = TRUE,
=======
            # sliderInput("bins",
            #             "Number of bins:",
            #             min = 1,
            #             max = 50,
            #             value = 30),
            
            # Input: Select a file ----
            fileInput("deckfile", "Choose Deck File",
                      multiple = FALSE,
>>>>>>> bb3dba6ea06c87bbb7fb560407acdb81d65df692
                      accept = c("text/csv",
                                 "text/comma-separated-values,text/plain",
                                 ".csv",
                                 ".txt")),
            
            # Horizontal line ----
            tags$hr(),
<<<<<<< HEAD
=======

>>>>>>> bb3dba6ea06c87bbb7fb560407acdb81d65df692
            
            # Input: Select User ----
            radioButtons("user", "User",
                         choices = c(Alex = "Alex",
                                     Nick = "Nick",
                                     Tom = "Tom",
                                     Cam = "Cam")
                         ),
<<<<<<< HEAD
=======
            # Input: Commander
            textInput("commander", "Commander",
                      placeholder = "Fblthp, The Lost"),
>>>>>>> bb3dba6ea06c87bbb7fb560407acdb81d65df692
            
            # Input: Select Date ----
            dateInput("deck_date", "Date",
                      value= Sys.Date()),
            
<<<<<<< HEAD
=======
            # Input: Result
            selectInput("result", "Placement Result",
                        c("1st" = 1,
                          "2nd" = 2,
                          "3rd" = 3,
                          "Fuck You" = 4)),
            
>>>>>>> bb3dba6ea06c87bbb7fb560407acdb81d65df692
            # Horizontal line ----
            tags$hr(),
            
            # Input: Select number of rows to display ----
<<<<<<< HEAD
            radioButtons("disp", "Display",
                         choices = c(Head = "head",
                                     All = "all"),
                         selected = "head")
=======
            # radioButtons("disp", "Display",
            #              choices = c(Head = "head",
            #                          All = "all"),
            #              selected = "head")
>>>>>>> bb3dba6ea06c87bbb7fb560407acdb81d65df692
        ),

        # Show a plot of the generated distribution
        mainPanel(
<<<<<<< HEAD
            plotOutput("distPlot"),
=======
            actionButton("submit", "Submit", class = "btn-success"),
>>>>>>> bb3dba6ea06c87bbb7fb560407acdb81d65df692
            tableOutput("upload")
        )
    )
))
