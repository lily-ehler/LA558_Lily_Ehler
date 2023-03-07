# Lily Ehler
# L A 558
# Exercise 7b

install.packages("leaflet", "tidycensus", "tidyverse")
library(leaflet)
library(tidycensus)
library(tidyverse)

# Coordinates from Google Maps
41.87552076604798
12.466045066475425

map <- leaflet() %>%
  addTiles() %>%  
  addMarkers(lng= 12.4660, lat=41.8755, popup="My Rome Apartment") %>%
  setView(lng= 12.4660, lat=41.8755, zoom = 17)
map  
