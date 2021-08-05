scry <- readRDS('edh_analytics/scryfall.rds')
df_new <- read.csv("C:/Users/CPriest/Downloads/weird cards.txt", header=FALSE, col.names = c("card_name"), sep = '\t') %>%
  mutate(count = gsub(" .*","", card_name),
         #remove card count, keep name
         card_name = gsub("^\\S* ","", card_name),
         #Remove text including "/" from double faced cards for joining. Ex fire//ice -> fire
         #Keep both, just in case
         name = sub("\\/.*", "", card_name),
         commander = "com",
         date = as.character("2021-08-06"),
         player = "input$user",
         result = "input$result",
         deckname = "input$deckfile$name")

t <- left_join(df_new, scry)
