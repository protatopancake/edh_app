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
library(dplyr)

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
ss <- gs4_get('https://docs.google.com/spreadsheets/d/1HN6snP_JzjjzM_0WBCwLznj10ouMIxW-mEXt0hYBefE/edit#gid=1571747905')

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    # output$distPlot <- renderPlot({
    # 
    #     # generate bins based on input$bins from ui.R
    #     x    <- faithful[, 2]
    #     bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # 
    #     # draw the histogram with the specified number of bins
    #     hist(x, breaks = bins, col = 'darkgray', border = 'white')
    # 
    # })
    
    output$upload <- renderTable({

        
        if (input$submit == 0)
            return()
        isolate({
            required <- req(input$deckfile)
            scry <- readRDS("scryfall.rds")
            df_new <- read.csv(input$deckfile$datapath, header=FALSE, col.names = c("card_name"), sep = '\t') %>%
                mutate(count = gsub(" .*","", card_name),
                       #remove card count, keep name
                       card_name = gsub("^\\S* ","", card_name),
                       #Remove text including "/" from double faced cards for joining. Ex fire//ice -> fire
                       #Keep both, just in case
                       name = sub("\\/.*", "", card_name),
                       commander = input$commander,
                       date = as.character(input$deck_date),
                       player = input$user,
                       result = input$result,
                       deckname = input$deckfile$name) %>%
                left_join(scry, by = c("name" = "name"))
            df <- sheet_append(ss,df_new, sheet = input$user)
            return(df_new %>%
                       head() %>%
                       select(count,
                              card_name,
                              commander,
                              date,
                              player,
                              result,
                              deckname,
                              mana_cost,
                              cmc,
                              type_line))
        })
        

    })
    
    
    #output$table <- renderTable({
        #req(input$deckfile)
        #head(read.csv(input$deckfile$datapath, header=FALSE, col.names = c("card_name"), sep = '\t'))
        #})
    #output$table2 <- renderTable(head(read_sheet(ss, sheet = input$user)))

})
