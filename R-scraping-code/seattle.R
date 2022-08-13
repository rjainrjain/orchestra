library(tidyverse)
library(rvest)

page <- "~/Desktop/orchestra research data/seattle.html"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)

people <- ((read_html(page) %>% html_nodes("main") %>% html_nodes(".fc-flex-instance"))[4:21])
people <- people %>% html_nodes("a")

for(i in 1:length(people)){
  strs <- str_split((people[i] %>% html_text2()), "\\n")
  strs <- strs[[1]]
  section <- strs[1]
  name <- str_trim(str_remove_all(strs[2], "\\*|\\+"))
  link <- people[i] %>% html_attr("href")
  if(length(strs)<3){
    title <- section
  } else {
    title <- strs[3]
    if(!str_detect(title, "Concertmaster|Associate|Principal|Assistant|Acting")){
      title <- section
    } else {
      title <- str_remove_all(title, " Chair")
      if(str_detect(title, "Acting")) {
        index <- str_locate(title, "Acting")[1]
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
  }
  if(!str_detect(section, "Personnel|Librarians")){
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
orchestra <- "Seattle Symphony"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))


