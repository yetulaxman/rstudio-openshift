# Esimerkkiskripti kuntarajojen piirtämisestä R:llä. 

## Maanmittauslaitoksen avoimet kuntakartat:
# https://tiedostopalvelu.maanmittauslaitos.fi/tp/kartta --> Kuntajako. Tallennusmuoto ESRI shapefile.
# Kartta pitää tilata ja se toimitetaan sähköpostilla.

## Paitulin kartat
# https://avaa.tdata.fi/web/paituli/latauspalvelu --> Maanmittauslaitos --> Hallintorajat
# tai https://avaa.tdata.fi/web/paituli/latauspalvelu --> Maanmittauslaitos -->Hallintorajat, teemakartoille, ilman merialueita

## Geoserverin kuntakartat (ilman merialueita)
# http://geo.stat.fi/geoserver/web/wicket/bookmarkable/org.geoserver.web.demo.MapPreviewPage?1 --> esim. Kunnat 2020 (1:1 000 000), tallennus shapefile-muodossa.
# suorat linkit: 
# 2019: http://geoserv.stat.fi:8080/geoserver/tilastointialueet/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=tilastointialueet:kunta1000k_2019&maxFeatures=3500&outputFormat=SHAPE-ZIP
# 2020: http://geoserv.stat.fi:8080/geoserver/tilastointialueet/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=tilastointialueet:kunta1000k_2020&maxFeatures=3500&outputFormat=SHAPE-ZIP

# Kaikkien karttojen koordinaatit ETRS-TM35FIN -muodossa (lisätietoja esim. https://fi.wikipedia.org/wiki/ETRS-TM35FIN)

# AR 13.2.2019
# MP 26.2.2020

#rm(list = ls())
library(sf)
library(ggplot2)
library(dplyr)

# Esimerkki Maanmittauslaitoksen tai Paitulin kartalla

## Ladataan tarvittavat aineistot. 

### SHP eli shapefile. Päätiedosto, jonka päälle kaikki rakentuu, kertoo muodot.
download.file(url = 'http://www.nic.funet.fi/index/geodata/mml/hallintorajat_milj_tk/2017/kunnat_2017_milj.shp', 
              destfile = 'kunnat_2017_milj.shp')

### DPF eli dBASE table file. Kertoo "muotojen" ominaisuuksia, kuten nimi yms.
download.file(url = 'http://www.nic.funet.fi/index/geodata/mml/hallintorajat_milj_tk/2017/kunnat_2017_milj.dbf', 
              destfile = 'kunnat_2017_milj.dbf')

### SHX eli spatial index file. 
download.file(url = 'http://www.nic.funet.fi/index/geodata/mml/hallintorajat_milj_tk/2017/kunnat_2017_milj.shx', 
              destfile = 'kunnat_2017_milj.shx')


# huom. shp-tiedosto vaatii kaverikseen shx- ja dpf tiedoston samaan kansioon.
kartta = read_sf("kunnat_2017_milj.shp") # Voit myös osoittaa valmiiksi lataamaasi tiedoston sijaintiin tässä

## Kaikki Suomen kunnat kartalle
ggplot() + 
  geom_sf(data = kartta) 

## Pisteitä kartalle: Tampere, Joensuu, Helsinki
latitude  = c(327629, 641652, 385884) # E 
longitude = c(6822513, 6944284, 6671746) # N
ggplot() + 
  geom_sf(data = kartta) +
  geom_point(aes(x = latitude, y = longitude))+
  geom_text(aes(x = latitude, y = longitude, label = c("Tampere", "Joensuu", "Helsinki")),hjust=0.5, vjust=-0.5)


## Piirretään ainoastaan valitut kunnat
Kainuun.kartta = kartta %>% 
  filter(NATCODE %in%  c(205, 765,777,290, 620, 697,105,578 )) # Kainuun kuntien kuntanumerot
ggplot() + 
  geom_sf(data = Kainuun.kartta, aes(fill=NAMEFIN)) 


## Valitaan alue koordinaattien perusteella
ggplot() + 
  geom_sf(data = kartta) +
  coord_sf(xlim = c(470000,674000), ylim = c(7050000,7260000)) 

## Maakuntarajat vahvistettuna
### Ladataan tarvittavat maakunta aineistot paitulista 
download.file(url = 'http://www.nic.funet.fi/index/geodata/mml/hallintorajat_milj_tk/2017/maakunnat_2017_milj.dbf', 
              destfile = 'maakunnat_2017_milj.dbf')

download.file(url = 'http://www.nic.funet.fi/index/geodata/mml/hallintorajat_milj_tk/2017/maakunnat_2017_milj.shp', 
              destfile = 'maakunnat_2017_milj.shp')

download.file(url = 'http://www.nic.funet.fi/index/geodata/mml/hallintorajat_milj_tk/2017/maakunnat_2017_milj.shx', 
              destfile = 'maakunnat_2017_milj.shx')

# huom. shp-tiedosto vaatii kaverikseen shx- ja dpf tiedoston samaan kansioon.
kartta.maakunta = read_sf("maakunnat_2017_milj.shp") #Paitulin maakuntajako ilman merialueita
ggplot() + 
  geom_sf(data = kartta) +
  geom_sf(data = kartta.maakunta, fill = NA, size = 1, color ="black") # maakuntarajat

## Luokan tai ryhmän mukaan väritettynä
# Tilastokeskuksen kuntaryhmitys
kuntaryhmitys = read.csv("http://www.stat.fi/meta/luokitukset/kunta/001-2019/kunta_kr_teksti.txt", 
                         skip = 2, sep = "\t",  
                         col.names=c("Kuntanumero", "Kunta", "Ryhmänumero", "Kuntaryhmitys"),
                         colClasses=c("Kuntanumero"="character"))
kartta.kuntaryhmityksella = left_join(kartta, kuntaryhmitys, by = c("NATCODE" = "Kuntanumero"))

ggplot() + 
  geom_sf(data = kartta.kuntaryhmityksella, aes(fill = Kuntaryhmitys)) +
  geom_sf(data = kartta.maakunta, fill = NA, size = 1, color ="black") +# maakuntarajat
  ggtitle("Tilastokeskuksen kuntaryhmitys")+
  scale_fill_viridis_d()+
  # ilman akseleita ja taustaa
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        rect = element_blank())
#ggsave("kuntaryhmitys.png")
