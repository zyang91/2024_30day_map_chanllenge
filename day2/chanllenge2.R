library(sf)
library(tidyverse)
library(leaflet)
library(tmap)

# Load the data
setwd("C:/Users/zyang/OneDrive/Desktop/traffic")
traffic <- st_read("traffic.shp")
philly<- st_read("City_Limits/City_Limits.shp")


traffic<- traffic %>%
  select(DLY_VMT,DLY_TRK_VM,VOL_CNT_DA,geometry)%>%
  rename(Daily_VMT = DLY_VMT, Daily_truck_VMT = DLY_TRK_VM, Count_Date = VOL_CNT_DA)


#st_write(traffic, "traffic.gpkg")

# Create a map
tmap_mode("view")
# Create the interactive map
tm <- tm_shape(traffic) +
  tm_lines(col = "Daily_VMT", palette = "Reds", style = "quantile", title.col = "Traffic Count") +
  tm_basemap("CartoDB.DarkMatter") +
  tm_layout(title = "Traffic Counts by Road Segment")
tm
