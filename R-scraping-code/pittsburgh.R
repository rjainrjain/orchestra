library(tidyverse)
library(rvest)

url <- "https://pittsburghsymphony.org/pso_home/web/musicians"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)

pairs <- ((read_html(url) %>% html_nodes(".container.content-wrapper")) %>% html_children())[2:45]

for(i in 1:length(pairs)){
  if(i%%2==1){
    section <- pairs[i] %>% html_text()
  } else {
    links <- pairs[i] %>% html_nodes("a")
    people <- str_split((pairs[i] %>% html_text2()), "\\n")
    people <- people[[1]]
    for(j in 1:length(people)){
      link <- paste0("https://pittsburghsymphony.org", (links[j] %>% html_attr("href")))
      if(str_ends(link, "NA")){
        link <- NA
      }
      name <- str_remove_all(str_trim(links[j] %>% html_text()), "\\*")
      strs <- str_split(people[j], "\\|") 
      if(length(strs)>1){
        str <- strs[2]
        if(str_detect(str, "Assistant|Associate|Principal|Concertmaster|Acting")){
          title <- str
        }
        else {
          title <- section
        }
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
orchestra <- "Pittsburgh Symphony Orchestra"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))