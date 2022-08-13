# Load libraries
library(tidyverse)
library(rvest)

# Let's set the main URL for the roster page
url <- "https://www.bsomusic.org/musicians/search/"

# Let's read that web page
rosterpage <- read_html(url)

# Let's get the names, links, titles
name <- rosterpage %>% html_nodes(".musician-Item__name") %>% html_text()
name <- str_replace_all(str_remove_all(name,"\\*"),"  "," ")
link <- rosterpage %>% html_nodes(".more") %>% html_attr("href")
link <- paste0("https://www.bsomusic.org",link)
title <- rosterpage %>% html_elements(".musican-list p") %>% html_text()

# from titles, ascertain section
section <- title
section <- str_remove_all(section, "Acting |Associate |Assistant |Principal |Emeritus|Fourth |Chair ")
for (i in 1:length(section)){
  if(str_detect(section[i], ",")){ # iterate and assign section based on title
    indices <- str_locate(section[i], ",")
    section[i] <- str_sub(section[i], 1, indices[1]-1)
  }
  if(str_detect(section[i], "Concertmaster")){
    section[i] <- "First Violin"
  } else if(str_detect(section[i], "Flute|Piccolo|Oboe|Clarinet|Bassoon")){
    section[i] <- "Woodwind"
  } else if(str_detect(section[i], "Trumpet|Trombone|Horn|Tuba")){
    section[i] <- "Brass"
  } else if(str_detect(section[i], "Timpani|Percussion|Harp")){
    section[i] <- "Percussion"
  } else if(str_detect(section[i], "Organ|Piano|Harpsichord")){
    section[i] <- "Keyboards"
  }
}

# Assemble into data frame
roster <- data.frame(section=section,name=name,link=link,title=title)

# determine whether musician is in leadership role or not
isLead <- title
for (i in 1:length(isLead)){
  if(str_detect(isLead[i], "Concertmaster|Principal")){
    isLead[i] = TRUE
  } else {
    isLead[i] = FALSE
  }
}
# add columns for orchestra and leadership status
roster$isLead <- isLead
orchestra <- "Baltimore Symphony Orchestra"
roster <- cbind(orchestra = orchestra, roster)

# Eliminate non-players
bad <- "Advisor|Conductor|Director|Librarian|Chorus|Partner"
roster <- roster[!str_detect(title,bad),]
roster <- unique(roster, FALSE,)
rownames(roster) = seq(length=nrow(roster))

write.csv(roster, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))


