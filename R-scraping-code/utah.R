library(tidyverse)
library(rvest)

url <- "https://utahsymphony.org/orchestra/musicians-utah-symphony/"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)

blocks <- (read_html(url) %>% html_nodes(".profile-list.section-block.section-grid"))[2:17]

for(i in 1:length(blocks)){
  people <- blocks[i] %>% html_nodes(".section-part.profile-list")
  section <- blocks[i] %>% html_nodes("h3") %>% html_text()
  for(j in 1:length(people)){
    name <- people[j] %>% html_nodes(".section-name") %>% html_text()
    link <- people[j] %>% html_nodes(".section-name") %>% html_nodes("a") %>% html_attr("href")
    title <- str_trim(people[j] %>% html_nodes(".section-position") %>% html_text())
    if(title==""){
      title <- section
    }
    if(name!="Vacant"){
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
orchestra <- "Utah Symphony"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))

