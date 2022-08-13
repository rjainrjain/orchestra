library(tidyverse)
library(rvest)

url <- "https://www.orsymphony.org/discover/orchestra/"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)

#pageList <- read_html(url) %>% html_nodes(".libfiftyfifty-content-heading") %>% html_nodes("a") %>% html_attr("href")
pageList <- c("https://www.orsymphony.org/discover/orchestra/strings/",
              "https://www.orsymphony.org/discover/orchestra/woodwinds/",
              "https://www.orsymphony.org/discover/orchestra/brass/",
              "https://www.orsymphony.org/discover/orchestra/percussion/")

for(i in 1:length(pageList)){
  page <- pageList[i]
  blocks <- read_html(page) %>% html_nodes(".team-block")
  for(j in 1:length(blocks)){
    section <- blocks[j] %>% html_nodes(".section-title") %>% html_text()
    people <- blocks[j] %>% html_nodes(".team-block-container-item-caption") 
    for (k in 1:length(people)){
      name <- str_remove_all(people[k] %>% html_nodes("h5") %>% html_text(), "\\*")
      link <- paste0("https://www.orsymphony.org", (people[k] %>% html_nodes("h5") %>% html_nodes("a") %>% html_attr("href")))
      link <- link[1]
      if(str_ends(link, "NA")){
        link <- NA
      }
      title <- people[k] %>% html_nodes(".title") %>% html_text()
      if(!str_detect(title, "Concertmaster|associate Concertmaster|Principal|Assistant|Acting")){
        title <- section
      } else {
        title <- str_remove_all(title, " Chair")
        if(str_detect(title, "Acting")) {
          index <- str_locate(title, "Acting")[1]
          if(index[1]!= 1){
            remove <- str_sub(title, 1, index[1]-1)
            title <- str_remove(title, remove)
          }
        } else if(str_detect(title, "associate")){
          index <- str_locate(title, "associate")[1]
          if(index[1]!= 1){
            remove <- str_sub(title, 1, index[1]-1)
            title <- str_remove(title, remove)
          }
        } else if(str_detect(title, "Associate")) {
          index <- str_locate(title, "Associate")[1]
          if(index[1]!= 1){
            remove <- str_sub(title, 1, index[1]-1)
            title <- str_remove(title, remove)
          }
        } else if(str_detect(title, "Assistant")) {
          index <- str_locate(title, "Assistant")[1]
          if(index[1]!= 1){
            remove <- str_sub(title, 1, index[1]-1)
            title <- str_remove(title, remove)
          }
        } else if(str_detect(title, "Concertmaster")) {
          index <- str_locate(title, "Concertmaster")[1]
          if(index[1]!= 1){
            remove <- str_sub(title, 1, index[1]-1)
            title <- str_remove(title, remove)
          }
        } else if(str_detect(title, "Principal")) {
          index <- str_locate(title, "Principal")[1]
          if(index[1]!= 1){
            remove <- str_sub(title, 1, index[1]-1)
            title <- str_remove(title, remove)
          }
        }
        
      }
      data <- rbind(data,data.frame(section=section,name=name,link=link,title=title))
    }
  }
}

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
orchestra <- "Oregon Symphony"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))