library(tidyverse)
library(rvest)

url <- "https://www.slso.org/en/musicians-slso/orchestra/"
data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)

links <- read_html(url) %>% html_nodes("td") %>% html_nodes("a") %>% html_attr("href")
blocks <- (read_html(url) %>% html_nodes("td") %>% html_nodes("p"))[3:24]
names <- str_trim(read_html(url) %>% html_nodes("td") %>% html_nodes("a") %>% html_text())

for(i in 1:length(blocks)){
  section <- str_split(((blocks[i] %>% html_children())[1]) %>% html_text2(), "\\n")[[1]][1]
  people <- str_trim((blocks[i] %>% html_children()) %>% html_text2())
  people <- people[!(people %in% c("", "\n"))]
  for(j in 1:(length(people))){
    people[j] <- str_remove_all(people[j], "\\n|\\*")
    if(people[j] %in% names){
      name <- people[j]
      link <- paste0("https://www.slso.org", links[which(names == name)])
      if(j<length(people) && str_detect(people[j+1], "Assistant|Associate|Principal|Concertmaster|Acting")){
        title <- people[j+1]
      } else{
        title <- section
      }
      data <- rbind(data,data.frame(section=section,name=name,link=link,title=title))
    }
  }
}
data <- unique(data, FALSE,)
data <- rbind(data[1:6,], c("FIRST VIOLINS", "Jessica Cheng Hellwege", "https://www.slso.org/en/musicians-slso/orchestra/jessica-cheng/", "FIRST VIOLINS"), data[-(1:6),])
data <- rbind(data[1:27,], c("SECOND VIOLINS", "Jecoliah Wang", NA, "SECOND VIOLINS"), data[-(1:27),])
data <- rbind(data[1:40,], c("CELLOS", "Elizabeth Chung", "https://www.slso.org/en/musicians-slso/orchestra/elizabeth-chung/", "CELLOS"), data[-(1:40),])
data <- rbind(data[1:41,], c("CELLOS", "James Czyzewski", "https://www.slso.org/en/musicians-slso/orchestra/james-czyzewski/", "CELLOS"), data[-(1:41),])
data <- rbind(data[1:42,], c("CELLOS", "Jennifer Humphreys", "https://www.slso.org/en/musicians-slso/orchestra/jennifer-humphreys/", "CELLOS"), data[-(1:42),])
data <- rbind(data[1:43,], c("CELLOS", "Alvin McCall", "https://www.slso.org/en/musicians-slso/orchestra/alvin-mccall/", "CELLOS"), data[-(1:43),])
data <- rbind(data[1:44,], c("CELLOS", "Bjorn Ranheim", "https://www.slso.org/en/musicians-slso/orchestra/bjorn-ranheim/", "CELLOS"), data[-(1:44),])
data <- rbind(data[1:45,], c("CELLOS", "Yin Xiong", "https://www.slso.org/en/musicians-slso/orchestra/yin-xiong/", "CELLOS"), data[-(1:45),])
data <- rbind(data[1:50,], c("DOUBLE BASSES", "Brendan Fitzgerald", "https://www.slso.org/en/musicians-slso/orchestra/brendan-fitzgerald/", "DOUBLE BASSES"), data[-(1:50),])
data <- rbind(data[1:51,], c("DOUBLE BASSES", "Sarah Hogan Kaiser", "https://www.slso.org/en/musicians-slso/orchestra/sarah-hogan-kaiser/", "DOUBLE BASSES"), data[-(1:51),])
data <- rbind(data[1:67,], c("CLARINETS", "Ryan Toher", NA, "CLARINETS"), data[-(1:67),])
data <- rbind(data[1:68,], c("E-FLAT CLARINET", "Ryan Toher", NA, "E-FLAT CLARINET"), data[-(1:68),])
data <- rbind(data[1:85,], c("TIMPANI", "Edouard Beyens", NA, "TIMPANI"), data[-(1:85),])
data <- rbind(data[1:88,], c("PERCUSSION", "Edouard Beyens", NA, "PERCUSSION"), data[-(1:88),])
data[87,4] <- "Associate Principal"
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
orchestra <- "St. Louis Symphony Orchestra"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))


