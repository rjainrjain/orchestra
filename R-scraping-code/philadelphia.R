library(tidyverse)
library(rvest)

url <- "https://www.philorch.org/your-philorch/meet-your-orchestra/musicians/"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)

nodes <- (read_html(url) %>% html_nodes(".rich-text") %>% html_children() %>% html_children())[9:117]
sections <- (read_html(url) %>% html_nodes(".rich-text") %>% html_children() %>% html_nodes("h4"))[1:18]


for(i in 1:length(nodes)){
  if((nodes[i] %>% html_text()) %in% (sections %>% html_text())){
    section <- str_remove_all(nodes[i] %>% html_text(), "&nbsp;")
  } else {
    link <- paste0("https://www.philorch.org", nodes[i] %>% html_nodes("a") %>% html_attr("href"))
    name <- read_html(link) %>% html_nodes(".main-content-header") %>% html_nodes("h1") %>% html_text()
    title <- str_remove_all(str_split(nodes[i] %>% html_text2(), "\\n")[[1]][1], nodes[i] %>% html_nodes("a") %>% html_text())
    title <- str_remove_all(title, ", ")
    if(str_trim(title)==""){
      title <- section
    }
    data <- rbind(data,data.frame(section=section,name=name,link=link,title=title))
  }
}
data[22,4] <- "Second Violins"

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
orchestra <- "The Philadelphia Orchestra"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))