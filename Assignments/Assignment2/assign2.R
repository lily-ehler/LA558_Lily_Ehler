# Lily Ehler
# L A 558
# Assignment 2

# Script for Map
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

# Script for Plot
teacher_data_2 <- read_excel("iowa_teacher_salaries_22_23.xlsx", "Plot")

perc_adv_degree <- teacher_data_2 %>%
  group_by(district_name2) %>%
  mutate(PercentAdvDegree = round(FT_adv_degree2 / FT_teachers2, 3)*100) %>%
  as.data.frame()

plot1 <- ggplot(data=perc_adv_degree, aes(x=district_name2, y=PercentAdvDegree)) +
  geom_bar(stat="identity", width=0.5, fill = "blue") +
  geom_text(aes(label=PercentAdvDegree), vjust=2.0, size=3.5,color="white")+
  theme_minimal()
plot1

plot1 + labs(title="Percent of Iowa Teachers with Advanced Degrees", x = "School District", y = "Percentage")

