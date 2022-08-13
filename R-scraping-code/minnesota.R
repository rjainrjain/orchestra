library(tidyverse)
library(rvest)

url <- "https://www.minnesotaorchestra.org/about/our-people/orchestra-musicians/"
page <- "~/Desktop/orchestra research data/minnesota.html"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)

people <- (read_html(page) %>% html_nodes(".ensemble-person"))[89:176]

for(i in 1:length(people)){
  name <- people[i] %>% html_nodes(".ensemble-person__name") %>% html_text()
  name <- str_c((str_sub(name, str_locate(name, ",")[1]+2, nchar(name))), " ", (str_sub(name, 1, str_locate(name, ",")[1]-1)))
  link <- people[i] %>% html_attr("href")
  title <- read_html(link) %>% html_nodes(".artist-page__role") %>% html_text()
  section <- people[i] %>% html_nodes(".ensemble-person__instrument") %>% html_text()
  data <- rbind(data,data.frame(section=section,name=name,link=link,title=title))
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
orchestra <- "Minnesota Orchestra"
data <- cbind(orchestra = orchestra, data)

# Eliminate non-players
bad <- "Advisor|Conductor|Director|Librarian|Chorus|Manager|Open|Emeritus"

data <- data[!str_detect(data[,4],bad),]
data <- data[!str_detect(data[,2],bad),]

write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))






















# blocks <- read_html(url) %>% html_nodes(".ensemble-instrument")
# 
# for (i in 1:length(blocks)) {
#   items <- blocks[i] %>% html_nodes("ensemble-instrument__list") %>% html_nodes(".ensemble-person")
#   for (j in 1:length(items)){
#     name <- items[j] %>% html_nodes(".ensemble-person__name") %>% html_text()
#     if (length(name) == 0) {
#       name <- NA
#     }
#     name <- str_trim(str_remove_all(name,"\\n"))
#     link <- items[j] %>% html_attr("href")
#     if (length(link) == 0) {
#       link <- NA
#     }
#     section <- blocks[i] %>% html_nodes(".ensemble-instrument__title") %>% html_text()
#     if(str_detect(section, "Concertmaster")){
#       section <- "First Violin"
#     } else if(str_detect(section, "Flute|Piccolo|Oboe|Clarinet|Bassoon")){
#       section <- "Woodwind"
#     } else if(str_detect(section, "Trumpet|Trombone|Horn|Tuba")){
#       section <- "Brass"
#     } else if(str_detect(section, "Timpani|Percussion|Harp")){
#       section <- "Percussion"
#     } else if(str_detect(section, "Organ|Piano|Harpsichord")){
#       section <- "Keyboards"
#     }
#     section <- str_trim(str_remove_all(section,"\\n"))
#     section <- str_remove_all(section, "Acting |Associate |Assistant |Principal |Emeritus")
#     
#     if(is.na(link)){
#       title <- section
#     } else {
#       title <- read_html(link) %>% html_nodes(".artist-page__role") %>% html_text()
#       if(str_detect(title, ",")){
#         indices <- str_locate(title, ",")
#         index <- indices[1]
#         title <- str_sub(title, 1, index-1)
#       } else {
#         title <- section
#       }
#     }
#     data <- rbind(data,data.frame(section=section,name=name,link=link,title=title))
#   }
# }
# 
# # Eliminate non-players
# bad <- "Advisor|Conductor|Director|Librarian|Chorus|Manager|Open|Emeritus"
# 
# data <- data[!str_detect(data[,4],bad),]
# data <- data[!str_detect(data[,1],bad),]
