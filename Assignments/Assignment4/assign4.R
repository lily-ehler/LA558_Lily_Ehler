# Lily Ehler
# L A 558
# Assignment 4

# Leaflet with markers
install.packages("leaflet", "leaflet.providers", "tidyverse", "sf")
library(leaflet)
library(leaflet.providers)
library(tidyverse)
library(sf)

drawing_sites <- read.csv("rome_drawing.csv", header = TRUE)

map <- leaflet(drawing_sites) %>% 
  addProviderTiles("Esri.WorldGrayCanvas", options = providerTileOptions
                   (minZoom = 4, maxZoom = 16)) %>%
  addCircles(~longitude, ~latitude, 
             popup = paste("<strong>", drawing_sites$name, 
              "</strong><br>", "Building Type: ", drawing_sites$type))
map

icon_pencil <- makeIcon(iconUrl = "pencil-icon.png", 
                        iconWidth = 18, iconHeight = 18)

draw_sf = st_as_sf(drawing_sites, 
                   coords = c("longitude", "latitude"), crs = 4326)

bounds1 <- draw_sf %>% 
  st_bbox() %>% 
  as.character()

map <- leaflet(drawing_sites) %>% 
  addProviderTiles("Esri.WorldGrayCanvas", options = providerTileOptions
                   (minZoom = 10, maxZoom = 16)) %>%
  addMarkers(~longitude, ~latitude, icon = icon_pencil,
             popup = paste("<strong>", drawing_sites$name, 
                           "</strong><br>", "Building Type: ", 
                           drawing_sites$type)) %>%
  fitBounds(bounds1[1], bounds1[2], bounds1[3], bounds1[4])
map

library(htmlwidgets)
saveWidget(map, "drawing.html", selfcontained = F, libdir = "lib")


# Leaflet choropleth map
install.packages("leaflet", "leaflet.providers", "tidyverse", "sf")
library(leaflet)
library(leaflet.providers)
library(tidyverse)
library(readxl)
library(sf)

real_zona <- st_read("ZU2.shp")
real_zona <- st_transform(real_zona, crs = 4326)

library("RColorBrewer")
display.brewer.all()

my_bins <- c(2000, 2500, 3000, 3500, 4000, 4500, 5000, Inf)
pal <- colorBin("YlGnBu", domain = real_zona$R_EST, bins = my_bins)

my_labels <- sprintf(
  "<strong>%s</strong><br/>Avg Value: €%s",
  real_zona$DENOMINAZI, real_zona$realestate
) %>% lapply(htmltools::HTML)

bounds2 <- real_zona %>% 
  st_bbox() %>% 
  as.character()

map2 <- leaflet() %>%
  setView(12.5, 41.9, 10)  %>%
  addProviderTiles("Esri.WorldGrayCanvas") %>%
  fitBounds(bounds2[1], bounds2[2], bounds2[3], bounds2[4])  %>%
  addPolygons(data = real_zona,
              fillColor = ~pal(real_zona$R_EST),
              weight = 0.5,
              opacity = 1,
              color = "grey",
              fillOpacity = 1,
              highlightOptions = highlightOptions(
                weight = 2,
                color = "black",
                fillOpacity = 1,
                bringToFront = TRUE),
              label = my_labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "10px",
                direction = "auto")) %>% 
  addLegend(pal = pal, values = real_zona$R_EST, opacity = 1, title = "Average Real Estate Value",
            position = "topright")
map2

library(htmlwidgets)
saveWidget(map2, "realestate.html", selfcontained = F, libdir = "lib")

