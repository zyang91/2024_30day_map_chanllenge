
# Following code is completed generate by AI (Chatgpt)

library(sf)
library(osmdata)
library(ggplot2)
library(tidyverse)

# Step 3: Define the area of interest (Philadelphia)
philly_bbox <- getbb("Philadelphia, Pennsylvania, USA")

# Step 4: Fetch road network data from OpenStreetMap
philly_highways <- opq(bbox = philly_bbox) %>% 
  add_osm_feature(key = "highway") %>% 
  osmdata_sf()

# Step 5: Filter and keep only important road types
# Include major road types: motorway, primary, secondary, tertiary
important_roads <- philly_highways$osm_lines %>%
  filter(highway %in% c("motorway", "primary", "secondary", "tertiary")) %>% 
  mutate(road_type = factor(highway, levels = c("motorway", "primary", "secondary", "tertiary")))

# Step 6: Plot the filtered road network
ggplot() +
  geom_sf(data = important_roads, aes(color = road_type), size = 0.5, alpha = 0.8) +  # Use road_type to color
  scale_color_manual(
    values = c("motorway" = "red", "primary" = "orange", "secondary" = "blue", "tertiary" = "green"),
    name = "Road Type"
  ) +  # Custom color palette for clarity
  labs(
    title = "Important Roadways in Philadelphia",
    subtitle = "Major road types: Motorway, Primary, Secondary, Tertiary",
    caption = "Data: OpenStreetMap | Visualization: R and ChatGPT"
  ) +
  theme_minimal()