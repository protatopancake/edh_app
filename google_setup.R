#Setup
#install.packages(c('googlesheets4', 'dplyr', 'jsonlite', 'stringr', 'purrr', 'rsconnect'))
#library(googledrive)
library(googlesheets4)

# designate project-specific cache
options(gargle_oauth_cache = ".secrets")

# check the value of the option, if you like
gargle::gargle_oauth_cache()

# trigger auth on purpose --> store a token in the specified cache
#drive_auth()
gs4_auth(cache=".secrets")

# see your token file in the cache, if you like
list.files(".secrets/")

