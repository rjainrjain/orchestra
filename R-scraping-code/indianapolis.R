library(tidyverse)
library(rvest)

url <- "https://www.indianapolissymphony.org/about/musicians/"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)


blocks <- read_html(url) %>% html_nodes(".musiciansList__section")
title <- blocks %>% html_nodes(".musiciansList__card-subheading") %>% html_text()
title <- str_trim(str_remove_all(title,"\\n"))

count <- 1
for (i in 1:length(blocks)) {
  items <- blocks[i] %>% html_nodes(".musiciansList__card")
  for (j in 1:length(items)){
    name <- items[j] %>% html_nodes(".musiciansList__card-heading") %>% html_text()
    if (length(name) == 0) {
      name <- NA
    }
    name <- str_trim(str_remove_all(name,"\\n|\\*|\\+"))
    link <- items[j] %>% html_nodes("a") %>% html_attr("href")
    if (length(link) == 0) {
      link <- NA
    }
    section <- blocks[i] %>% html_nodes(".musicianList__heading") %>% html_text()
    if(str_detect(section, "Concertmaster")){
      section <- "First Violin"
    } else if(str_detect(section, "English Horn|Flute|Piccolo|Oboe|Clarinet|Bassoon|Contrabassoon")){
      section <- "Woodwind"
    } else if(str_detect(section, "Trumpet|Trombone|Horn|Tuba")){
      section <- "Brass"
    } else if(str_detect(section, "Timpani|Percussion|Harp")){
      section <- "Percussion"
    } else if(str_detect(section, "Organ|Piano|Harpsichord")){
      section <- "Keyboards"
    }
    section <- str_trim(str_remove_all(section,"\\n"))
    section <- str_remove_all(section, "Acting |Associate |Assistant |Principal |Emeritus")
    if(str_detect(title[count], ",")){
     indices <- str_locate(title[count], ",")
     index <- indices[1]
     title[count] <- str_sub(title[count], 1, index-1)
    }
    else if(str_detect(title[count], "Chair|CHAIR|chair")){
      title[count] <- ""
    }
    if(title[count] == "") {
      title[count] <- section
    }
    data <- rbind(data,data.frame(section=section,name=name,link=link,title=title[count]))
    count <- count+1
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
orchestra <- "Indianapolis Symphony Orchestra"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))
