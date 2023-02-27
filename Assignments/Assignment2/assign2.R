# Lily Ehler
# L A 558
# Assignment 2

install.packages(c("tidyverse", "readxl", "sf"))

library("sf")
library(tidyverse)
library("readxl")

teacher_data <- read_excel("iowa_teacher_salaries_22_23.xlsx", "R")

iowaCounties_sf <- st_read("Counties.shp")

teacher_data_list <- teacher_data %>%
  group_by(county_code) %>%
  summarize(district_enrollment = sum(district_enrollment), 
            FT_teachers = sum(FT_teachers),
            FT_adv_degree = sum(FT_adv_degree),
            dCount = n(),
            FT_avg_salary = (sum(FT_avg_salary)/dCount),
            FT_avg_age = (sum(FT_avg_age)/dCount)) 
teacher_data_list

iowaCounties_sf <- iowaCounties_sf %>% 
  rename("county_code" = "COUNTY_ID")

class(iowaCounties_sf$county_code) = "character"

assign2map <- left_join(iowaCounties_sf, teacher_data_list, by = "county_code")

ggplot(assign2map) + 
  geom_sf(aes(fill = FT_avg_salary)) +
  ggtitle("Average Salary for Full Time Teachers in Iowa") + 
  theme_void() +
  theme(plot.title=element_text(hjust=0.5))
