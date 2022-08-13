# Load libraries
library(tidyverse)
library(rvest)

# Let's set the main URL for the roster page
url <- "https://www.bso.org/about/musicians/bso-musicians"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)

blocks <- (read_html(url) %>% html_nodes(".block-roster"))[2:22]

for(i in 1:length(blocks)){
  section <- str_trim(blocks[i] %>% html_nodes(".block-roster__title") %>% html_text())
  nodes <- blocks[i] %>% html_nodes(".block-roster__item")
  for(j in 1:length(nodes)){
    link <- nodes[j] %>% html_nodes(".block-roster__link") %>% html_attr("href")
    if(length(link)==0){link <- NA}
    name <- str_trim(nodes[j] %>% html_nodes(".block-roster__name") %>% html_text())
    if(length(name)==0){name <- NA}
    title <- (str_trim(nodes[j] %>% html_nodes(".block-roster__label-1") %>% html_text()))[1]
    if(is.na(title)){
      title <- section
    }
    else if(length(title)==0){
      title <- section
    }
    if(!is.na(link)){
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
orchestra <- "Boston Symphony Orchestra"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))















# 
# # Let's read that web page
# rosterpage <- read_html(url)
# 
# # Let's get the names, links, titles
# name <- rosterpage %>% html_nodes(".block-roster__name") %>% html_text()
# link <- rosterpage %>% html_nodes(".block-roster__link") %>% html_attr("href")
# blocks <- rosterpage %>% html_elements("section")
# listElement <- blocks %>% html_elements(".block-roster__text")
# title <- rosterpage %>% html_nodes(".block-roster__label-1") %>% html_text()
# name <- str_remove_all(name,"\n|\t|  ")
# title <- str_remove_all(title,"\n|\t|  ")
# for (i in 1:length(name)){
#   print(name[i])
#   print(link[i])
# }
# # from titles, ascertain section
# section <- title
# section <- str_remove_all(section, "Acting |Associate |Assistant |Principal |Emeritus")
# for (i in 1:length(section)){ # iterate and assign section based on title
#   if(str_detect(section[i], ",")){
#     indices <- str_locate(section[i], ",")
#     section[i] <- str_sub(section[i], 1, indices[1]-1)
#   }
#   if(str_detect(section[i], "Concertmaster")){
#     section[i] <- "First Violin"
#   } else if(str_detect(section[i], "Flute|Piccolo|Oboe|Clarinet|Bassoon")){
#     section[i] <- "Woodwind"
#   } else if(str_detect(section[i], "Trumpet|Trombone|Horn|Tuba")){
#     section[i] <- "Brass"
#   } else if(str_detect(section[i], "Timpani|Percussion|Harp")){
#     section[i] <- "Percussion"
#   } else if(str_detect(section[i], "Organ|Piano|Harpsichord")){
#     section[i] <- "Keyboards"
#   }
# }
# 
# # determine whether musician is in leadership role or not
# isLead <- title
# for (i in 1:length(isLead)){
#   if(str_detect(isLead[i], "Concertmaster|Principal")){
#     isLead[i] = TRUE
#   } else {
#     isLead[i] = FALSE
#   }
# }
# 
# # Assemble into data frame
# roster <- data.frame(name=name,title=title,link=link,section=section,isLead=isLead)
# 
# # Eliminate non-players
# bad <- "Advisor|Conductor|Director|Librarian|Chorus"
# roster <- roster[!str_detect(title,bad),]