# the necessary packages----
library(DT)
library(RPostgres)
library(shiny)
library(shinythemes)
library(shinyWidgets)
library(tidyverse)

# connect to the kpop database----
con <- dbConnect(
  drv = dbDriver('Postgres'), 
  dbname = 'kpopa',
  host = 'db-postgresql-nyc1-44203-do-user-8018943-0.b.db.ondigitalocean.com', 
  port = 25061,
  user = 'apan5310a',
  password = 'rqg3aqqc2z4s6d1l',
  sslmode = 'require'
)

# the list of artists----
artsts <- c(
  'Apink',
  'BIGBANG', 
  'BLACKPINK', 
  'BTS', 
  'Chungha',
  'CLC',
  'Everglow',
  'EXO', 
  'GOT7',
  'iKON',
  'ITZY',
  'IU',
  'Mamamoo',
  'Oh My Girl',
  'Red Velvet',
  'Stray Kids',
  'Sunmi',
  'Twice'
)

# disconnect from the kpop database----
onStop(
  function()
  {
    dbDisconnect(con)
  }
)

