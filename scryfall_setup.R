#Here we take data downloaded from Scryfall's Oracle cards database, flatten it, and format it for joining
#https://scryfall.com/docs/api/bulk-data

#Install Packages
#install.packages('jsonlite')
#install.packages('dplyr')
#install.packages('stringr')
#install.packages('purrr')

library(jsonlite)
library(dplyr)
library(stringr)
library(purrr)

scry <- fromJSON('oracle-cards-20210805090503.json', flatten=TRUE) %>%
  #head(12) %>%
  select(name,
         scryfall_uri,
         mana_cost,
         cmc,
         type_line,
         oracle_text,
         colors,
         color_identity,
         #keywords,
         rarity,
         edhrec_rank,
         image_uris.small,
         image_uris.normal,
         image_uris.large,
         image_uris.png,
         related_uris.edhrec
         ) %>%
  mutate(colors = as.character(colors),
         name = str_trim(sub("\\/.*", "", name), side = "both"),
         cid_w = map(color_identity, str_detect, pattern = "W"),
         cid_w = map_lgl(cid_w, any),
         cid_u = map(color_identity, str_detect, pattern = "U"),
         cid_u = map_lgl(cid_u, any),
         cid_b = map(color_identity, str_detect, pattern = "B"),
         cid_b = map_lgl(cid_b, any),
         cid_r = map(color_identity, str_detect, pattern = "R"),
         cid_r = map_lgl(cid_r, any),
         cid_g = map(color_identity, str_detect, pattern = "G"),
         cid_g = map_lgl(cid_g, any)) %>%
  select(-color_identity)

saveRDS(scry, "edh_analytics/scryfall.rds")
