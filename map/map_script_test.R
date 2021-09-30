library(htmlwidgets)
library(htmltools)
library(leaflet)
library(tidyverse)
library(readr)
library(DT)

WHAM <- read.csv("/Users/garrettknowlton/Documents/CDL/InteractiveMap/WHAMclean21Nov2019.csv", stringsAsFactors=F)


datatable(head(WHAM))


groupColors <- colorFactor(c("#663300", "#ffcc00", "#669999", "#cc33ff", "#ff3300", "#00cc99" ), domain=c("CC - Carbon and Climate", "O - Other","U - Uncategorized","W - Wildlife", "WFS - Wildland Fire and Smoke","WNR - Water and Natural Resources"

mWHAMptsDesc <- leaflet(WHAM) %>% addProviderTiles(providers$CartoDB.Positron) %>% 
  setView(-77.886388, 34.129995, zoom = 3)%>% 
  addCircleMarkers(~Longitude, ~Latitude, 
                   popup = paste("Category", WHAM$Group, "<br><br>",
                                 "", WHAM$Description),
                   weight = 10, 
                   radius=4, 
                   color=~groupColors(Group), 
                   stroke = F,  
                   fillOpacity = 0.8) %>%
  addLegend("bottomright", 
            colors= c("#663300", "#ffcc00", "#669999", "#cc33ff", "#ff3300", "#00cc99" ), labels=c("CC - Carbon and Climate", "O - Other","U - Uncategorized","W - Wildlife", "WFS - Wildland Fire and Smoke","WNR - Water and Natural Resources"), 
            title="WHAM Categories") 


mWHAMptsDesc



currentWD <- getwd()
dir.create("static/leaflet", showWarnings = FALSE)
setwd("static/leaflet")
saveWidget(mWHAMptsDesc, "mWHAMptsDesc.html")
setwd(currentWD)
