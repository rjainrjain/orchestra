library(tidyverse)
library(rvest)

url <- "https://content.thespco.org/people/orchestra-musicians/"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)

nodes <- (read_html(url) %>% html_nodes(".content") %>% html_children() %>% html_children())[2] %>% html_children() 
sections <- read_html(url) %>% html_nodes(".orchestra-section-header") 

for(i in 1:length(nodes)){
  if((nodes[i] %>% html_text()) %in% (sections %>% html_text())){
    section <- str_remove_all(nodes[i] %>% html_text(), "\\n|\\t")
  } else {
    link <- paste0("https://content.thespco.org", (nodes[i] %>% html_nodes(".information") %>% html_nodes("a") %>% html_attr("href"))[1])
    name <- (nodes[i] %>% html_nodes(".information") %>% html_nodes("a") %>% html_text())[1]
    if(length(nodes[i] %>% html_nodes(".information") %>% html_nodes(".musician_title"))!=0){
      title <- nodes[i] %>% html_nodes(".information") %>% html_nodes(".musician_title") %>% html_text()
      if(str_detect(title, ",")){
        title <- str_sub(title, 1, (str_locate(title, ","))[[1]][1]-1)
      }
      if(!str_starts(title, "Assistant|Associate|Principal|Concertmaster|Acting")){
        title <- section
      }
    } else{
      title <- section
    }
    data <- rbind(data,data.frame(section=section,name=name,link=link,title=title))
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
orchestra <- "The Saint Paul Chamber Orchestra"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))

