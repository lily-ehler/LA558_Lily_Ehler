# Lily Ehler
# L A 558
# Assignment 3

# Script for TidyCensus Graph
install.packages(c("tidycensus", "tidyverse"))
library(tidycensus)
library(tidyverse)
library(ggplot2)

vars <- load_variables(2021, "acs1")
View(vars)

med_1bed_rent <- get_acs(
  geography = "state",
  variables = "B25031_003",
  year = 2021, 
  geometry = TRUE
)

select_med1bed_rent <- med_1bed_rent[c(3, 23, 38, 39, 51),]

plot1 <- ggplot(data=select_med1bed_rent, aes(x=NAME, y=estimate)) +
  geom_bar(stat="identity", width=0.7, fill = "deepskyblue") +
  geom_text(aes(label=estimate), vjust=2.0, size=3.5,color="white")+
  theme_minimal()
plot1

plot1 + labs(title="Median Gross Rent for Selected States 2021", 
             subtitle = str_wrap("A comparison of rent prices in five of the 
                                 states I'm considering moving to after 
                                 graduation.", 60), 
             x = "State", 
             y = "Gross Rent Estimate")

# Script for IDB Map
install.packages(c("tidycensus", "tidyverse", "idbr"))
library(tidycensus)
library(tidyverse)
library(ggplot2)
library(idbr)

vars = idb_variables()
view(vars)

SE_asia <- c("Brunei", "Burma", "Cambodia", "Timor-Leste", "Indonesia",
             "Laos", "Malaysia", "Philippines", "Singapore", "Thailand",
             "Vietnam")

idb_api_key('a6341676837c727ad639803cafabf469155abdf6')

GR_SE_asia <- get_idb(
  country = SE_asia,
  variables = "GR",
  year = 2018
)

# Kept getting error message :( 
# No encoding supplied: defaulting to UTF-8.
# Error: lexical error: invalid char in json text.
#                   <html>     <head>         <titl
# (right here) ------^

# Script for TidyCensus Map