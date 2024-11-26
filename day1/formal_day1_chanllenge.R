library(tidyverse)
library(sf)
library(leaflet)

setwd("/Users/apple/Desktop/data")

crime_2023 <- st_read("2023/incidents_part1_part2.shp")

crime_2023<-crime_2023 %>% 
  filter(str_starts(text_gener, "Homicide")) %>%
  select(text_gener, geometry,dispatch_d)%>%
  rename("crime_type" = text_gener, "date" = dispatch_d)
crime_2023$year<- 2023

Philly<- st_read("City_Limits/City_Limits.shp")


leaflet(data) %>%
  addProviderTiles(providers$CartoDB.Positron, # Simplified white basemap
                   options = providerTileOptions(noWrap = TRUE)) %>%
  addCircleMarkers(
    data = crime_2023,
    radius = 3,
    color = "red",
    popup = ~paste0("<strong>Crime Type:</strong> ", crime_type, "<br>",
                    "<strong>Date:</strong> ", date),
    clusterOptions = markerClusterOptions()
  ) %>%
  addPolygons(data = Philly, 
              color = "black", 
              weight = 2, 
              fill = FALSE) %>%
  addControl("<h3>Interactive Homicide Map of Philadelphia</h3>
              <p>Made by Zhanchao Yang</p>",
             position = "topright")%>%
  addControl(
    html = "<p style='font-size:12px;'>Data Source: Open Data Philly, Police data</p>",
    position = "bottomright"  # Control position: "topleft", "topright", "bottomleft", "bottomright"
)%>%
  addScaleBar(position = "bottomright") %>%
  addControl(
    html = '<div style="padding: 5px; background-color: white; border-radius: 5px;">
              <h4 style="margin: 0;">Crime Type</h4>
              <div style="display: flex; align-items: center;">
                <div style="width: 12px; height: 12px; background-color: red; border-radius: 50%; margin-right: 5px;"></div>
                <span>Homicide</span>
              </div>
            </div>',
    position = "bottomleft"
  )

map<-leaflet(data) %>%
  addProviderTiles(providers$CartoDB.Positron, # Simplified white basemap
                   options = providerTileOptions(noWrap = TRUE)) %>%
  addCircleMarkers(
    data = crime_2023,
    radius = 3,
    color = "red",
    popup = ~paste0("<strong>Crime Type:</strong> ", crime_type, "<br>",
                    "<strong>Date:</strong> ", date),
    clusterOptions = markerClusterOptions()
  ) %>%
  addPolygons(data = Philly, 
              color = "black", 
              weight = 2, 
              fill = FALSE) %>%
  addControl("<h3>Interactive Homicide Map of Philadelphia</h3>
              <p>Made by Zhanchao Yang</p>",
             position = "topright")%>%
  addControl(
    html = "<p style='font-size:12px;'>Data Source: Open Data Philly, Police data</p>",
    position = "bottomright"  # Control position: "topleft", "topright", "bottomleft", "bottomright"
  )%>%
  addScaleBar(position = "bottomright") %>%
  addControl(
    html = '<div style="padding: 5px; background-color: white; border-radius: 5px;">
              <h4 style="margin: 0;">Crime Type</h4>
              <div style="display: flex; align-items: center;">
                <div style="width: 12px; height: 12px; background-color: red; border-radius: 50%; margin-right: 5px;"></div>
                <span>Homicide</span>
              </div>
            </div>',
    position = "bottomleft"
  )

library(htmlwidgets)
saveWidget(map, "leaflet_map.html", selfcontained = TRUE)
