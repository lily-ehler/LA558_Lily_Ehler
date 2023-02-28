# Lily Ehler
# L A 558
# Exercise 6a

# Script for Map
install.packages(c("tidycensus", "tidyverse", "usmap"))
library(tidycensus)
library(tidyverse)
library(usmap)
library(ggplot2)

vars <- load_variables(2021, "acs5")
View(vars)

canadian_born <- get_acs(
  geography = "state",
  variables = "B05006_167",
  year = 2021,
  geometry = TRUE
)

canadian_born_continental <- canadian_born[-c(2, 28, 41, 46),]

ggplot(data = canadian_born_continental, aes(fill = estimate)) + 
  geom_sf()+
  scale_fill_distiller(palette = "BuPu", 
                       direction = 1) + 
  labs(title = "   Canadian Born Population 2021") + 
  theme_void()
