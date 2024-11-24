library(tidyverse)
library(sf)
library(leaflet)

setwd("/Users/apple/Desktop/data")

crime_2023 <- st_read("2023/incidents_part1_part2.shp")

crime_2023<-crime_2023 %>% 
  filter(str_starts(text_gener, "Homicide")) %>%
  select(text_gener, geometry)
crime_2023$year<- 2023

leaflet(data) %>%
  addProviderTiles(providers$CartoDB.Positron, # Simplified white basemap
                   options = providerTileOptions(noWrap = TRUE)) %>%
  addCircleMarkers(
    data = crime_2023,
    radius = 3,
    color = "red",
    clusterOptions = markerClusterOptions()
  ) %>%
  addControl("<h3>Interactive Homicide Map of Philadelphia</h3>
              <p>Made by Zhanchao Yang</p>",
             position = "topright")%>%
  addControl(
    html = "<p style='font-size:12px;'>Data Source: Open Data Philly, Police data</p>",
    position = "bottomright"  # Control position: "topleft", "topright", "bottomleft", "bottomright"
)