library(tidyverse)
library(rvest)

url <- "https://www.mso.org/about/orchestra/roster/"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)

pairs <- (read_html(url) %>% html_nodes(".col-md-9.roster") %>% html_children())[3:48]

for(i in 1:length(pairs)){
  if(i%%2==1){
    section <- pairs[i] %>% html_text()
  } else {
    blocks <- pairs[i] %>% html_nodes("li")
    for(j in 1:length(blocks)){
      link <- blocks[j] %>% html_nodes("a") %>% html_attr("href")
      name <- blocks[j] %>% html_nodes("a") %>% html_text()
      if(!identical(name, character(0))){
        title <- blocks[j] %>% html_text()
        title <- str_remove(title, name)
        if(str_trim(title)==""){
          title <- section
        } else if(str_detect(title, ",")){
          len <- nchar(title)
          title <- str_sub(title, (str_locate(title, ",")[1]+2), len)
          if(str_detect(title, ",")){
            title <- str_sub(title, 1, (str_locate(title, ",")[1]-1))
          } else if(str_detect(title, "Chair")){
            title <- section
          }
        }
      data <- rbind(data,data.frame(section=section,name=name,link=link,title=title))
      }
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
orchestra <- "Milwaukee Symphony Orchestra"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))






















# 
# blocks <- read_html(url) %>% html_nodes(".list-unstyled")
# blocks <- blocks[-(length(blocks))]
# blocks <- blocks[-1]
# sectionList <- read_html(url) %>% html_nodes(".col-md-9") %>% html_nodes("h3") %>% html_text()
# sectionList <- sectionList[-(length(sectionList))]
# 
# count <- 1
# for (i in 1:length(blocks)) {
#   items <- blocks[i] %>% html_nodes(".roster-title")
#   for (j in 1:length(items)){
#     name <- items[j] %>% html_nodes("a") %>% html_text()
#     if (length(name) == 0) {
#       name <- NA
#     }
#     else{
#       name <- str_trim(str_remove_all(name,"\\n"))
#       link <- items[j] %>% html_nodes("a") %>% html_attr("href")
#       section <- sectionList[i]
#       if(str_detect(section, "Concertmaster")){
#         section <- "First Violin"
#       } else if(str_detect(section, "Flute|Piccolo|Oboe|Clarinet|Bassoon")){
#         section <- "Woodwind"
#       } else if(str_detect(section, "Trumpet|Trombone|Horn|Tuba")){
#         section <- "Brass"
#       } else if(str_detect(section, "Timpani|Percussion|Harp")){
#         section <- "Percussion"
#       } else if(str_detect(section, "Organ|Piano|Harpsichord")){
#         section <- "Keyboards"
#       }
#       section <- str_trim(str_remove_all(section,"\\n"))
#       #section <- str_remove_all(section, "Acting |Associate |Assistant |Principal |Emeritus")
#       title <- items[i] %>% html_text()
#       title <- str_trim(str_remove_all(title,"\\n"))
#       removeName <- str_locate(title, name)
#       title <- str_sub(title, (removeName[2]+1),)
#       if(is.na(title)) {
#         title <- section
#       }
#       if(str_starts(title, ",")){
#         title <- str_sub(title, 3, )
#       }
#       if(str_detect(title, ",")){
#         indices <- str_locate(title, ",")
#         index <- indices[1]
#         title <- str_sub(title, 1, index-1)
#       } else if(str_detect(title, "Chair|CHAIR|chair")){
#         title <- section
#       }
#       data <- rbind(data,data.frame(section=section,name=name,link=link,title=title))
#     }
#   }
# }
# 
# # Eliminate non-players
# bad <- "Advisor|Conductor|Director|Librarian|Chorus|Manager|Open|Emeritus"
# 
# data <- data[!str_detect(data[,4],bad),]
# data <- data[!str_detect(data[,2],bad),]
