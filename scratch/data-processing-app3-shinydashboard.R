# load packages ----
library(tidyverse)

# read in raw data
lake_raw <- read_csv(here::here("raw-data", "FCWO_lakemonitoringdata_2011_2022_daily.csv"))

# average depth & temperature ----
avg_depth_temp <- lake_raw %>% 
  select(Site, Depth, BedTemperature) %>% # select columns
  filter(Depth != "NaN") %>% # NaN are not NAs, get rid of NA from depth column
  drop_na(BedTemperature) %>% # removes rows with NA from temp column 
  group_by(Site) %>% 
  summarise(
    AvgDepth = round(mean(Depth), 1),
    AvgTemp = round(mean(BedTemperature), 1)
  )

# join dfs together ----
joined_dfs <- full_join(lake_raw, avg_depth_temp)

# unique lakes ----
unique_lakes <- joined_dfs %>% 
  select(Site, Latitude, Longitude, Elevation, AvgDepth, AvgTemp) %>% 
  distinct()

# save processed data ----
write_csv(unique_lakes, file = here::here("shinydashboard", "data", "lake_data_processed.csv"))
