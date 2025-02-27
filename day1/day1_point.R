library(tidyverse)
library(sf)
library(leaflet)

setwd("/Users/apple/Desktop/data")

# prep data
crime_2023 <- st_read("2023/incidents_part1_part2.shp")
crime_2022 <- st_read("2022/incidents_part1_part2.shp")
crime_2021 <- st_read("2021/incidents_part1_part2.shp")
crime_2020 <- st_read("2020/incidents_part1_part2.shp")
crime_2019 <- st_read("2019/incidents_part1_part2.shp")


crime_2023<-crime_2023 %>%
  filter(str_starts(text_gener, "Homicide")) %>%
  select(text_gener, geometry)
crime_2023$year<- 2023

crime_2022<-crime_2022 %>%
  filter(str_starts(text_gener, "Homicide")) %>%
  select(text_gener, geometry)
crime_2022$year<- 2022

crime_2021<-crime_2021 %>%
  filter(str_starts(text_gener, "Homicide")) %>%
  select(text_gener, geometry)
crime_2021$year<- 2021

crime_2020<-crime_2020 %>%
  filter(str_starts(text_gener, "Homicide")) %>%
  select(text_gener, geometry)
crime_2020$year<- 2020

crime_2019<-crime_2019 %>%
  filter(str_starts(text_gener, "Homicide")) %>%
  select(text_gener, geometry)
crime_2019$year<- 2019

# create map

leaflet() %>%
  addTiles() %>%
  addCircleMarkers(
    data = crime_2023,
    radius = 3,
    color = "blue",
    popup = ~paste("Year:", year),
    clusterOptions = markerClusterOptions()
  ) %>%
  addCircleMarkers(
    data = crime_2022,
    radius = 3,
    color = "red",
    popup = ~paste("Year:", year),
    clusterOptions = markerClusterOptions()
  ) %>%
  addCircleMarkers(
    data = crime_2021,
    radius = 3,
    color = "green",
    popup = ~paste("Year:", year),
    clusterOptions = markerClusterOptions()
  ) %>%
  addCircleMarkers(
    data = crime_2020,
    radius = 3,
    color = "yellow",
    popup = ~paste("Year:", year),
    clusterOptions = markerClusterOptions()
  ) %>%
  addCircleMarkers(
    data = crime_2019,
    radius = 3,
    color = "purple",
    popup = ~paste("Year:", year),
    clusterOptions = markerClusterOptions()
  )
