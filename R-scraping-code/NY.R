# Load libraries
library(tidyverse)
library(rvest)

orchestra <- "New York Philharmonic"
data <- as.data.frame(read.csv(file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv")))
# 
# data$title <- ifelse(str_trim(data$title)=="", data$section, data$title)
# data <- data[1:95,]
# 
# rownames(data) = seq(length=nrow(data))
# 
# isLead <- data$title
# for (i in 1:length(isLead)){
#   if(str_detect(isLead[i], "Concertmaster|Principal")){
#     isLead[i] = TRUE
#   } else {
#     isLead[i] = FALSE
#   }
# }
# data$isLead <- isLead
# data <- cbind(orchestra = orchestra, data)
# 

data <- data[,-(1:2)]
data <- cbind(orchestra = orchestra, data) 

write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))





















# library(RSelenium)
# library(pbmcapply)
# 
# # This tutorial is incredibly helpful
# # http://joshuamccrain.com/tutorials/web_scraping_R_selenium.html
# 
# # Set up Rselenium
# rD <- rsDriver(browser="firefox", port=4545L, verbose=F)
# remDr <- rD[["client"]]
# 
# # Navigate to page, grab it
# remDr$navigate("https://nyphil.org/about-us/meet/musicians-of-the-orchestra#section")
# page <- remDr$getPageSource()[[1]] %>%
#   read_html(page)
# 
# # Close up RSelenium
# remDr$close()
# rD$server$stop()
# 
# # Get all the sections
# sections <- page %>%
#   html_nodes(".large-block-grid-6")
# 
# # Write function to process each block
# processBlock <- function(sectionblock){
#   
#   sectionname <- sectionblock %>%
#     html_nodes("h3") %>%
#     html_text()
#   
#   artist <- sectionblock %>%
#     html_nodes(".link-to-artist")
#   
#   name <- artist %>%
#     html_text()
#   
#   link <- artist %>%
#     html_attr("href")
#   
#   link <- paste0("https://nyphil.org",link)
#   
#   title <- sectionblock %>%
#     html_nodes(".chairTitleLink") %>%
#     html_text()
#   
#   return(data.frame(section = sectionname, name = name, link = link, title = title))
#   
# }
# 
# data <- lapply(sections, processBlock)
# data <- bind_rows(data)
