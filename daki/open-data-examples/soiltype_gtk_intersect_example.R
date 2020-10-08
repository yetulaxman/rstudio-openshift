
library(ggplot2)
library(dplyr)
library(sf)

# Example of using soil data from GTK
# File downloaded from 
# https://hakku.gtk.fi/en/locations/search
# Superficial deposits of Finland 1:200 000 (sediment polygon)

fgdb <- "maapera_200k_etrs_tm35fin_gdb/maapera_200k.gdb" #File path of file from gtk

# Check layers in file
st_layers(fgdb)

# Read in data from selected layer in file
sfdata <- read_sf(dsn = fgdb, layer = "mp200k_maalajit")

# Take a look at first three lines of data
head(sfdata, 3)

# Use a box shaped filter to select a smaller area of the map
# Otherwise plotting will take ages
# Selecting Kainuu region from the map
# UTM (ETRS-TM35FIN) kainuu bbox: xmin: 464864 ymin: 7060437 xmax: 664076 ymax: 7271038

filt_bbox <- sf::st_bbox(c(xmin = 570000,
                           ymin = 7090000, 
                           xmax = 600000, 
                           ymax = 7120000),
                         crs = st_crs(3067)) %>%
  sf::st_as_sfc(.)

find_data <- sf::st_intersects(sfdata, filt_bbox) # Find soil data that fits into our coordinate box
filt_data <- sfdata[which(lengths(find_data) != 0), ]

# See how soil types are distributed inside the box
table(filt_data$PINTAMAALAJI) %>% as.data.frame()

# Plot the geometries, color according to soiltype (PINTAMAALAJI)
p <- ggplot() +
  geom_sf(data = filt_data, aes(geometry = SHAPE, fill = PINTAMAALAJI, stroke = 0)) + 
  coord_sf(datum = st_crs(3067),
           xlim = c(570000,600000),
           ylim = c(7100000,7120000))
p

# Example of joining other (point) coordinates to the map
# Read ESRI Shapefile of EU Registry on Idustrial Sites from SYKE
# Downloaded from https://www.syke.fi/en-US/Open_information/Spatial_datasets/Downloadable_spatial_dataset#P
# Coordinate system 3067:	http://www.opengis.net/def/crs/EPSG/0/3067

industrial_sites <- read_sf("tuotantolaitokset/Tuotantolaitokset.shp") %>%
  st_set_crs(3067)

# Join map (points) of industrial sites with map of sediments (polygons)
sites_sediments <- st_intersection(industrial_sites %>% select(parentComp, geometry), filt_data)

# Plot industrial sites and sediment map
p2 <- ggplot() +
  geom_sf(data = filt_data, aes(geometry = SHAPE, fill = PINTAMAALAJI, stroke = 0)) +
  geom_sf(data = sites_sediments, size = 5, color = "blue")+
  geom_sf_label(data = sites_sediments, label = sites_sediments$parentComp, nudge_y = 2500)
p2


