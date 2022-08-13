library(tidyverse)
library(rvest)

page <- read_html("~/Desktop/orchestra research data/pacific.html")
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)

people <- page %>% html_nodes(".listing-sec")

for(i in 1:length(people)){
  section <- people[i] %>% html_nodes(".music-grid") %>% html_nodes("strong") %>% html_text()
  name <- people[i] %>% html_nodes(".music-grid") %>% html_nodes("h4") %>% html_text()
  link <- people[i] %>% html_nodes(".listing-fig") %>% html_nodes("a") %>% html_attr("href")
  title <- people[i] %>% html_nodes(".music-grid") %>% html_nodes("p") %>% html_text()
  if(!(length(title) == 1)){
    title <- str_trim(title)[2]
    if(str_detect(title, ",")){
      index <- str_locate(title, ",")[[1]]
      title <- str_sub(title, 1, index-1)
    }
    if(str_detect(title, "Chair")){
      title <- section
    }
  } else {
    title <- section
  }
  data <- rbind(data,data.frame(section=section,name=name,link=link,title=title))
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
orchestra <- "Pacific Symphony"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))