library(tidyverse)
library(rvest)

url <- "https://www.sandiegosymphony.org/about-the-sdso/orchestra-members/"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)

pairs <- ((read_html(url) %>% html_nodes(".orchestra")) %>% html_children())[2:41]

for(i in 1:length(pairs)){
  if(i%%2==1){
    section <- pairs[i] %>% html_text()
  } else {
    people <- pairs[i] %>% html_nodes(".orchestra-member")
    for(j in 1:length(people)){
      name <- people[j] %>% html_nodes(".orchestra-member-name") %>% html_nodes("strong") %>% html_text()
      link <- paste0("https://www.sandiegosymphony.org", people[j] %>% html_nodes("a") %>% html_attr("href"))
      if(!(length(people[j] %>% html_nodes(".orchestra-member-name") %>% html_nodes("em"))==0)){
        title <- people[j] %>% html_nodes(".orchestra-member-name") %>% html_nodes("em") %>% html_text()
      } else {
        title <- section
      }
      if(!(str_detect(title, "Emeritus") | (section=="Piccolo") | (section=="Tuba"))){
        data <- rbind(data,data.frame(section=section,name=name,link=link,title=title))
      }
    }
  }
}
data$name <- str_remove_all(data$name, "\\*")


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
orchestra <- "San Diego Symphony"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))

