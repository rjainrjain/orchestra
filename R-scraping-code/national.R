library(tidyverse)
library(rvest)

url <- "https://www.kennedy-center.org/nso/home/about/who-we-are/nso-musicians/"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)

blocks <- read_html(url) %>% html_nodes(".adage-block")
blocks = blocks[-16]
blocks = blocks[2:20]
sectionList <- blocks %>% html_nodes("header") %>% html_text()
sectionList <- sectionList[-(length(sectionList))]
blocks = blocks[-19]

for (i in 1:length(blocks)) {
  items <- blocks[i] %>% html_nodes(".badge-details") 
  for (j in 1:length(items)){
    name <- items[j] %>% html_nodes("a") %>% html_text()
    if (length(name) == 0) {
      name <- NA
    }
    else{
      name <- str_trim(str_remove_all(name,"\\n"))
      link <- str_c("https://www.kennedy-center.org", (items[j] %>% html_nodes("a") %>% html_attr("href")))
      section <- sectionList[i]

      section <- str_trim(str_remove_all(section,"\\n"))
      #section <- str_remove_all(section, "Acting |Associate |Assistant |Principal |Emeritus")
      title <- items[j] %>% html_nodes(".preheader") %>% html_text()
      title <- str_trim(str_remove_all(title,"\\n"))
      #removeName <- str_locate(title, name)
      #title <- str_sub(title, (removeName[2]+1),)
      if(is.na(title)) {
        title <- section
      }
      if(str_starts(title, "Regularly")){
        title <- ""
      }
      if(str_detect(title, ",")){
        indices <- str_locate(title, ",")
        index <- indices[1]
        title <- str_sub(title, 1, index-1)
      } else if(str_detect(title, "Chair|CHAIR|chair")){
        title <- section
      }
      if((str_trim(title))==""){
        title <- section
      }
      data <- rbind(data,data.frame(section=section,name=name,link=link,title=title))
    }
  }
}

# Eliminate non-players
bad <- "Advisor|Conductor|Director|Librarian|Chorus|Manager|Open|Emeritus"

#data <- data[!str_detect(data[,4],bad),]
#data <- data[!str_detect(data[,2],bad),]

rownames(data) = seq(length=nrow(data))

isLead <- data$title
for (i in 1:length(isLead)){
  if(str_detect(isLead[i], "Concertmaster|CONCERTMASTER|Principal")){
    isLead[i] = TRUE
  } else {
    isLead[i] = FALSE
  }
}
data$isLead <- isLead
orchestra <- "National Symphony Orchestra"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))
