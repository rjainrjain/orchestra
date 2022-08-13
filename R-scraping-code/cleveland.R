library(tidyverse)
library(rvest)

url <- "https://www.clevelandorchestra.com/discover/meet-the-musicians/"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)

sections <- (read_html(url) %>% html_nodes(".col-lg-9") %>% html_children())[3:7]
pairs <- sections %>% html_nodes(".row")

for(i in 1:length(pairs)){
  if(i%%2==1){
    section <- str_remove_all(pairs[i] %>% html_text(), "\\n")
  } else {
    people <- pairs[i] %>% html_nodes(".col-md-4.col-6")
    for(j in 1:length(people)){
      name <- people[j] %>% html_nodes("a") %>% html_text()
      link <- paste0("https://www.clevelandorchestra.com", people[j] %>% html_nodes("a") %>% html_attr("href"))
      if(!(length(people[j] %>% html_nodes(".card-body") %>% html_nodes("h5"))==0)){
        title <- people[j] %>% html_nodes(".card-body") %>% html_nodes("h5") %>% html_text()
      } else {
        title <- section
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
orchestra <- "The Cleveland Orchestra"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))

