library(tidyverse)
library(rvest)

url <- "https://www.sfsymphony.org/About-SFS/SF-Symphony-Musicians"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)


people <- read_html(url) %>% html_nodes(".feature")

for(i in 1:length(people)){
  section <- str_trim(people[i] %>% html_nodes(".subheader") %>% html_text())
  name <- people[i] %>% html_nodes(".header") %>% html_text()
  link <- paste0("https://www.sfsymphony.org", people[i] %>% html_nodes("a") %>% html_attr("href"))
  title <- str_remove_all(str_trim(people[i] %>% html_nodes(".description") %>% html_nodes("p") %>% html_text()), "\\r|\\n")
  if(!length(people[i] %>% html_nodes(".description") %>% html_nodes("p"))==0){
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
data <- data[1:88,]


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
orchestra <- "San Francisco Symphony"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))

