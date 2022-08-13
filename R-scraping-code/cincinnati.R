library(tidyverse)
library(rvest)

url <- "https://www.cincinnatisymphony.org/about/the-orchestra/"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)


blocks <- read_html(url) %>% html_nodes(".artist-block")
title <- read_html(url) %>% html_nodes(".caption") %>% html_text("")
title <- title[!str_detect(title,"Chair")]
for (i in 1:length(title)){
  if(title[i] == ""){
    title <- title[-i]
  }
}
count <- 1
for (i in 1:length(blocks)) {
  items <- blocks[i] %>% html_nodes(".artist-block-item")
  for (j in 1:length(items)){
    name <- items[j] %>% html_nodes(".artist-block-item-details-name") %>% html_text()
    if (length(name) == 0) {
      name <- NA
    }
    name <- str_trim(str_remove_all(name,"\\n"))
    link <- items[j] %>% html_nodes(".artist-block-item-link") %>% html_attr("href")
    if (length(link) == 0) {
      link <- NA
    }
    else {
      link <- str_c("https://www.cincinnatisymphony.org", link)
    }
    section <- title[count]
    if(str_detect(section, "Concertmaster")){
      section <- "First Violin"
    } else if(str_detect(section, "Flute|Piccolo|Oboe|Clarinet|Bassoon")){
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
    data <- rbind(data,data.frame(section=section,name=name,link=link,title=title[count]))
    count <- count+1
  }
}

# Eliminate non-players
bad <- "Advisor|Conductor|Director|Librarian|Chorus|Manager|Open"

data <- data[!str_detect(data[,4],bad),]
data <- data[!str_detect(data[,2],bad),]


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
orchestra <- "Cincinnati Symphony Orchestra"
data <- cbind(orchestra = orchestra, data)

rownames(data) = seq(length=nrow(data))

write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))


