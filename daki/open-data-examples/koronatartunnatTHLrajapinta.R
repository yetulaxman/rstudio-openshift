# Esimerkkikoodi THL:n rajapinnan hyödyntämiseen Suomen koronatartuntojen ja testausmäärien tarkastelussa.
# Rajapinnan kuvaus ja lisätietoja: 
# https://thl.fi/fi/tilastot-ja-data/aineistot-ja-palvelut/avoin-data/varmistetut-koronatapaukset-suomessa-covid-19-

# AR 4/2020

#rm(list=ls())
library(rjstat)

# rajapinnan osoite
url = "https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case.json?"

# rajapinnan dimensiot (huom. kaikki yhdistelmät eivät ole mahdollisia)
mittari.tartunnat = "measure-444833"
mittari.testit = "measure-445356"
mittari.asukasmaara = "measure-445344"
aika.viikko = "dateweek2020010120201231-443686"
aika.paiva = "dateweek2020010120201231-443702L"
alue.shp = "hcdmunicipality2020-445222"
alue.kunta = "hcdmunicipality2020-445268L"
sukupuoli = "sex-444328"
ikaryhma = "ttr10yage-444309"
# dimensiot: https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case.dimensions.json

# Esimerkiksi koronatartunnat sairaanhoitopiirin mukaan päiväkohtaisesti
url.kutsu =paste0(url, "column=", mittari.tartunnat, "&row=", aika.paiva, "&row=", alue.shp)
# Luetaan aineisto
aineisto = fromJSONstat(readLines(url.kutsu, encoding = "UTF-8"))$`Tartuntatautirekisterin COVID-19 tapaukset`
# Muutetaan value-sarake numeeriseksi
aineisto$value = as.numeric(aineisto$value)

## Vaihtoehtoiset url-kutsut:
# Koronatartunnat sairaanhoitopiirin mukaan viikkokohtaisesti: url.kutsu =paste0(url, "column=", mittari.tartunnat, "&row=", aika.viikko, "&row=", alue.shp)
# Koronatartunnat kunnittain (huom. vain jos tartuntoja kunnassa yli 5 kpl): url.kutsu =paste0(url, "column=", mittari.tartunnat, "&row=", alue.kunta)
# Koronatartunnat sukupuolen mukaan: url.kutsu =paste0(url, "column=", mittari.tartunnat, "&row=", sukupuoli)
# Koronatartunnat ikäryhmittäin: url.kutsu =paste0(url, "column=", mittari.tartunnat, "&row=", ikaryhma)
# Testausmäärät sairaanhoitopiireittäin: url.kutsu =paste0(url, "column=", mittari.testit, "&row=", alue.shp)
# Testausmäärät viikossa: url.kutsu =paste0(url, "column=", mittari.testit, "&row=", aika.viikko)
# Testausmäärät päivässä: url.kutsu =paste0(url, "column=", mittari.testit, "&row=", aika.paiva)
# Asukasmäärä sairaanhoitopiireittäin: url.kutsu =paste0(url, "column=", mittari.asukasmaara, "&row=", alue.shp)
# Asukasmäärä kunnittain: url.kutsu =paste0(url, "column=", mittari.asukasmaara, "&row=", alue.kunta)