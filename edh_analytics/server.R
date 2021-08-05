#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
#library(googledrive)
library(googlesheets4)

#Credentials
rsconnect::setAccountInfo(name='protatopancake', token='2F63FE44A51ECB6A18F42C27D3794208', secret='XlFuBz5em8FBjhm+xBazIC9QRaEg+C3r9XJFVZsH')

#Drive setup
#db <- read_sheet('https://docs.google.com/spreadsheets/d/1Z-YTXKaRtEXrp3GI20atOcF_438XTbE_NWgvM9JGLVM/edit?usp=sharing')
#g_id <- "497183850484-gcmlneljkd35s2mhtuvlmuk3jb21uqnd.apps.googleusercontent.com"
#g_secret <- "QLfbEBaDL9omtGCO--8rDiH7"
#email <- 'cpriest006@gmail.com'
#gs4_auth(path= "edh_analytics/edhapp-322002-8171ece0310d.json")
#gs4_auth_configure(api_key = '497183850484-gcmlneljkd35s2mhtuvlmuk3jb21uqnd.apps.googleusercontent.com')
# options(
#     gargle_oauth_cache = ".secrets",
#     gargle_oauth_email = TRUE#,
#     #httr_oauth_cache=TRUE
# )
gs4_auth(cache=".secrets", email=TRUE)
ss <- gs4_get('https://docs.google.com/spreadsheets/d/1Z-YTXKaRtEXrp3GI20atOcF_438XTbE_NWgvM9JGLVM/edit#gid=0')

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })
    
    output$upload <- renderTable({
        
        req(input$deckfile)
        #df_old <- read_sheet(ss, sheet = input$user)
        df_new <- read.csv(input$file1$datapath, header=FALSE, col.names = c("card_name"), sep = '\t')
        #sheet_append(ss, data= df_new, sheet = input$user)
        sheet_append(ss,read.csv(input$file1$datapath, header=FALSE, col.names = c("card_name"), sep = '\t'), sheet = input$user)
        
    })
    
    output$table <- renderTable(head(read.csv(input$file1$datapath, header=FALSE, col.names = c("card_name"), sep = '\t')))
    output$table2 <- renderTable(head(read_sheet(ss, sheet = input$user)))

})
