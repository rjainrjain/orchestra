library(tidyverse)
library(rvest)

url <- "https://www.dso.org/about-the-dso/meet-the-orchestra"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)


nodes <- read_html(url) %>% html_nodes(".content-panel__inner p")
nodes <- nodes[-38]
nodes <- nodes[-37]
num <- length(nodes)-9

for(j in 1:num) {
  if(j%%2==0){  
    nameList <- nodes[j] %>% html_nodes("a") %>% html_text()
    linkList <- nodes[j] %>% html_nodes("a") %>% html_attr("href")
    if(j==28){
      nameList <- nameList[-1]
      nameList <- nameList[-2]
      linkList <- linkList[-1]
      linkList <- linkList[-2]
    }
    sectionList <- nameList
    titleList <- sectionList
    
    for(i in 1:length(linkList)){
      part <- linkList[i]
      artistLink <- str_c("https://www.dso.org", part)
      sectionList[i] <- read_html(artistLink) %>% html_nodes(".artist-panel__instrument") %>% html_text()
      classes <- read_html(artistLink) %>% html_nodes("*") %>% html_attr("class")  %>% unique()
      for(l in 2:length(classes)){
        if(str_detect(classes[l], "artist-panel__suffix")){
          titleList[i] <- read_html(artistLink) %>% html_nodes(".artist-panel__suffix") %>% html_text()
          if(str_detect(titleList[i], ",")){
           indices <- str_locate(titleList[i], ",")
           index <- indices[1]
           titleList[i] <- str_sub(titleList[i], 1, index-1)
          }
          break
        }
        else{
          titleList[i] <- sectionList[i]
        }
      }
      if(str_detect(titleList[i], "Chair|chair|CHAIR")){
        titleList[i] <- sectionList[i]
      }
      
      data <- rbind(data,data.frame(section=sectionList[i],name=nameList[i],link=linkList[i],title=titleList[i]))
    }
  }
}

# Eliminate non-players
bad <- "Advisor|Conductor|Director|Library|Stage|Manager|Open|Emeritus|Keyboard"

data <- data[!str_detect(data[,4],bad),]
data <- data[!str_detect(data[,1],bad),]

rownames(data) = seq(length=nrow(data))

isLead <- data$title
for (i in 1:length(isLead)){
  if(str_detect(isLead[i], "Concertmaster|Principal")){
    isLead[i] = TRUE
  } else {
    isLead[i] = FALSE
  }
}
data$isLead <- isLead
orchestra <- "Detroit Symphony Orchestra"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))

