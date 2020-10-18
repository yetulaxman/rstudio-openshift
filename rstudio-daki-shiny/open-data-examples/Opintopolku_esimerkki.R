# Esimerkkiskripti koulutusten hakemiseen Opintopolun rajapinnasta. 
# 1. Haetaan koulutusluokituksen koulutukset
# 2. Haetaan koulutuksiin liittyvät alakoodit
# 3. Poimitaan niistä tutkintotyyppi, koulutusalat ja koulutusasteet 
# 4. Yhdistetään koulutukset-tauluun
# AR 2/2020

# Opintopolun Swagger: https://virkailija.opintopolku.fi/koodisto-service/rest/api-docs?url=/koodisto-service/rest/swagger.json

#rm(list=ls())
library(dplyr)
library(jsonlite)
library(tidyr)

## Haetaan opintopolun avoimesta rajapinnasta kaikki suomen koulutukset
url.koulutus = "https://virkailija.opintopolku.fi/koodisto-service/rest/json/koulutus/koodi"
koulutukset = fromJSON(url.koulutus, flatten=TRUE) %>% 
  unnest(metadata) %>% # avataan listamuotoinen metadata-kenttä
  select(koodiUri, koodiArvo, voimassaAlkuPvm, voimassaLoppuPvm, nimi, kuvaus, kieli) %>% 
  filter(kieli == "FI") %>% 
  rename("Koulutuksen nimi" = "nimi")

## Haetaan koulutuksiin liittyvät alakoodit
alakoodit = NULL
for(i in seq(1,nrow(koulutukset))){
  url.alakoodit = paste0("https://virkailija.opintopolku.fi/koodisto-service/rest/json/relaatio/sisaltyy-alakoodit/", koulutukset$koodiUri[i])
  data.list.koulutukset_i = fromJSON(url.alakoodit, flatten=TRUE) # Palauttaa kullekin koulutuskoodille (koodiUrille) kaikki siihen liittyvät alakoodit
  if (length(data.list.koulutukset_i) > 0){
    data.list.koulutukset_i$koulutusKooriUri = koulutukset$koodiUri[i] # lisätään koulutuskoodin koodiUri
    alakoodit = rbind(alakoodit, data.list.koulutukset_i)
  }
}

data.alakoodit =alakoodit %>% 
  unnest(metadata) %>%  # avataan listamuotoinen metadata-kenttä
  select(koulutusKooriUri, koodiUri, koodiArvo, koodisto.koodistoUri, nimi, kieli) %>% 
  filter(kieli == "FI")

## Poimitaan alakoodeista tutkintotyyppi, koulutusalat ja koulutusasteet   
Koulutus.tutkintotyyppi = data.alakoodit %>% filter(koodisto.koodistoUri == "tutkintotyyppi" ) %>% rename("Tutkintotyyppi" = "nimi")
Koulutus.koulutusala1 = data.alakoodit%>% filter(koodisto.koodistoUri == "kansallinenkoulutusluokitus2016koulutusalataso1") %>% rename("Koulutusala, taso1" = "nimi")
Koulutus.koulutusala2 = data.alakoodit%>% filter(koodisto.koodistoUri == "kansallinenkoulutusluokitus2016koulutusalataso2") %>% rename("Koulutusala, taso2" = "nimi")
Koulutus.koulutusaste1 = data.alakoodit%>% filter(koodisto.koodistoUri == "kansallinenkoulutusluokitus2016koulutusastetaso1") %>% rename("Koulutusaste, taso1" = "nimi")
Koulutus.koulutusaste2 = data.alakoodit%>% filter(koodisto.koodistoUri == "kansallinenkoulutusluokitus2016koulutusastetaso2") %>% rename("Koulutusaste, taso2" = "nimi")

## Yhdistetään tutkintotyyppi, koulutusalat ja koulutusasteet koulutukset-tauluun
koulutukset = koulutukset %>% 
  left_join(select(Koulutus.tutkintotyyppi, koulutusKooriUri, Tutkintotyyppi), by = c("koodiUri" = "koulutusKooriUri")) %>% 
  left_join(select(Koulutus.koulutusala1, koulutusKooriUri,`Koulutusala, taso1`), by = c("koodiUri" = "koulutusKooriUri")) %>% 
  left_join(select(Koulutus.koulutusala2, koulutusKooriUri, `Koulutusala, taso2`), by = c("koodiUri" = "koulutusKooriUri")) %>% 
  left_join(select(Koulutus.koulutusaste1, koulutusKooriUri, `Koulutusaste, taso1`), by = c("koodiUri" = "koulutusKooriUri")) %>% 
  left_join(select(Koulutus.koulutusaste2, koulutusKooriUri, `Koulutusaste, taso2`), by = c("koodiUri" = "koulutusKooriUri"))