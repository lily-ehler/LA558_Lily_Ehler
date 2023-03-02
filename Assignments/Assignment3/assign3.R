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
install.packages(c("tidycensus", "tidyverse"))
library(tidycensus)
library(tidyverse)
library(ggplot2)

install.packages("RColorBrewer") 
library("RColorBrewer") 

census_api_key('0af4f7c302526ddc6cfe8f1196b0804138f5459b', overwrite = TRUE, install = TRUE)

vars <- load_variables(2018, "acs1")
View(vars)

dc_surround <- c("DC", "MD", "WV", "NC", "VA", "DE")

cons_med_earn <- get_acs(
  state = dc_surround,
  geography = "county",
  variables = "B24031_005",
  year = 2018, 
  geometry = TRUE
)

plot1 <- ggplot(data = cons_med_earn) +
  geom_sf(aes(fill = estimate)) + 
  scale_fill_distiller(palette = "RdPu", 
                       direction = 1) +
  theme(rect = element_blank(), axis.ticks = element_blank(), 
        axis.text.x = element_blank(), axis.text.y = element_blank()) +
  labs(title = "Construction Industry Earnings 2018", 
       fill="Median Earnings",
       subtitle = str_wrap("A comparison of median earnings in the construction
       industry in five states surrounding Washington DC.", 80))
plot1

# Script for Excel-data Graph
install.packages(c("tidyverse", "readxl", "sf"))

library("sf")
library(tidyverse)
library("readxl")
library(ggplot2)
library("dplyr")  

dogs_cats <- read_excel("dogs_n_cats.xlsx")
head(dogs_cats)

animals <- pull(dogs_cats,animal)                 
print(animals)
animal_V <- as.factor(animals) 

country1 <- pull(dogs_cats,country)
print(country1)
country_V <- as.factor(country1)

dogs_cats2 <- dogs_cats
dogs_cats2["animal2"] <- animal_V
dogs_cats2["country2"] <- country_V
head(dogs_cats2)

plot2 <- dogs_cats2 %>% 
  group_by(animal2)

plot2 %>%
  ggplot( aes(x=year, y=amount, group=animal2, color=animal2)) +
  geom_line(size=1.5) +
  geom_point(shape=21, color="black", fill="black", size=2) +
  theme_minimal() +
  facet_wrap(~ country2) +
  labs(title="Comparison of Pet Numbers in Italy and the UK, 2015-2021", 
       x = "Year", 
       y = "Number of Pets in Millions",
       color = "Pet")