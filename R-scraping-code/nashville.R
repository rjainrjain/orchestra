library(tidyverse)
library(rvest)

data <- data.frame(section=NULL,name=NULL,link=NULL,title=NULL)

data <- rbind(data,data.frame(section="First Violin",name="Jun Iwasaki",link="https://www.nashvillesymphony.org/about/orchestra-conductors/jun-iwasaki/",title="Concertmaster"))
data <- rbind(data,data.frame(section="First Violin",name="Erin Hall",link="https://www.nashvillesymphony.org/about/orchestra-conductors/erin-hall/",title="Acting Associate Concertmaster"))
data <- rbind(data,data.frame(section="First Violin",name="Gerald C. Greer",link="https://www.nashvillesymphony.org/about/orchestra-conductors/gerald-c-greer/",title="Acting Assistant Concertmaster"))
data <- rbind(data,data.frame(section="First Violin",name="Kristi Seehafer",link="https://www.nashvillesymphony.org/about/orchestra-conductors/kristi-seehafer/",title="First Violin"))
data <- rbind(data,data.frame(section="First Violin",name="John Maple",link="https://www.nashvillesymphony.org/about/orchestra-conductors/john-maple/",title="First Violin"))
data <- rbind(data,data.frame(section="First Violin",name="Paul Tobias",link="https://www.nashvillesymphony.org/about/orchestra-conductors/paul-tobias/",title="First Violin"))
data <- rbind(data,data.frame(section="First Violin",name="Beverly Drukker",link="https://www.nashvillesymphony.org/about/orchestra-conductors/beverly-drukker/",title="First Violin"))
data <- rbind(data,data.frame(section="First Violin",name="Anna Lisa Hoepfinger",link="https://www.nashvillesymphony.org/about/orchestra-conductors/anna-lisa-hoepfinger/",title="First Violin"))
data <- rbind(data,data.frame(section="First Violin",name="Kirsten Mitchell",link="https://www.nashvillesymphony.org/about/orchestra-conductors/kirsten-mitchell/",title="First Violin"))
data <- rbind(data,data.frame(section="First Violin",name="Isabel Bartles",link=NA,title="First Violin"))
data <- rbind(data,data.frame(section="First Violin",name="Charles Dixon",link=NA,title="First Violin"))
data <- rbind(data,data.frame(section="First Violin",name="Eun Young Jung",link=NA,title="First Violin"))
data <- rbind(data,data.frame(section="First Violin",name="Charissa Leung",link=NA,title="First Violin"))
data <- rbind(data,data.frame(section="First Violin",name="Sarah Page",link=NA,title="First Violin"))
data <- rbind(data,data.frame(section="Second Violin",name="Jung-Min Shin",link="https://www.nashvillesymphony.org/about/orchestra-conductors/jung-min-shin/",title="Acting Principal"))
data <- rbind(data,data.frame(section="Second Violin",name="Jimin Lim",link="https://www.nashvillesymphony.org/about/orchestra-conductors/jimin-lim/",title="Acting Assistant Principal"))
data <- rbind(data,data.frame(section="Second Violin",name="Amy Helman",link=NA,title="Second Violin"))
data <- rbind(data,data.frame(section="Second Violin",name="Annaliese Kowert",link=NA,title="Second Violin"))
data <- rbind(data,data.frame(section="Second Violin",name="Louise Morrison",link="https://www.nashvillesymphony.org/about/orchestra-conductors/louise-morrison/",title="Second Violin"))
data <- rbind(data,data.frame(section="Second Violin",name="Laura Ross",link="https://www.nashvillesymphony.org/about/orchestra-conductors/laura-ross/",title="Second Violin"))
data <- rbind(data,data.frame(section="Second Violin",name="Johna Smith",link="https://www.nashvillesymphony.org/about/orchestra-conductors/johna-bradley-smith/",title="Second Violin"))
data <- rbind(data,data.frame(section="Second Violin",name="Koko Watanabe",link=NA,title="Second Violin"))
data <- rbind(data,data.frame(section="Second Violin",name="Jeremy Williams",link=NA,title="Second Violin"))
data <- rbind(data,data.frame(section="Second Violin",name="Pei-Ju Wu",link=NA,title="Second Violin"))
data <- rbind(data,data.frame(section="Viola",name="Daniel Reinker",link="https://www.nashvillesymphony.org/about/orchestra-conductors/daniel-reinker/",title="Principal"))
data <- rbind(data,data.frame(section="Viola",name="Shu-Zheng Yang",link="https://www.nashvillesymphony.org/about/orchestra-conductors/shu-zheng-yang/",title="Assistant Principal"))
data <- rbind(data,data.frame(section="Viola",name="Judith Ablon",link="https://www.nashvillesymphony.org/about/orchestra-conductors/judith-ablon/",title="Viola"))
data <- rbind(data,data.frame(section="Viola",name="Hari Bernstein",link="https://www.nashvillesymphony.org/about/orchestra-conductors/hari-bernstein/",title="Viola"))
data <- rbind(data,data.frame(section="Viola",name="Bruce Christensen",link="https://www.nashvillesymphony.org/about/orchestra-conductors/bruce-christensen/",title="Viola"))
data <- rbind(data,data.frame(section="Viola",name="Michelle Lackey Collins",link="https://www.nashvillesymphony.org/about/orchestra-conductors/michelle-lackey-collins/",title="Viola"))
data <- rbind(data,data.frame(section="Viola",name="Christopher Farrell",link="https://www.nashvillesymphony.org/about/orchestra-conductors/christopher-farrell/",title="Viola"))
data <- rbind(data,data.frame(section="Viola",name="Anthony Parce",link="https://www.nashvillesymphony.org/about/orchestra-conductors/anthony-parce",title="Viola"))
data <- rbind(data,data.frame(section="Viola",name="Melinda Whitley",link="https://www.nashvillesymphony.org/about/orchestra-conductors/melinda-whitley/",title="Viola"))
data <- rbind(data,data.frame(section="Viola",name="Clare Yang",link="https://www.nashvillesymphony.org/about/orchestra-conductors/clare-yang/",title="Viola"))
data <- rbind(data,data.frame(section="Cello",name="Kevin Bate",link="https://www.nashvillesymphony.org/about/orchestra-conductors/kevin-bate/",title="Principal"))
data <- rbind(data,data.frame(section="Cello",name="Una Gong",link=NA,title="Assistant Principal"))
data <- rbind(data,data.frame(section="Cello",name="Anthony LaMarchina",link="https://www.nashvillesymphony.org/about/orchestra-conductors/anthony-lamarchina/",title="Principal Cello Emeritus"))
data <- rbind(data,data.frame(section="Cello",name="Bradley Mansell",link="https://www.nashvillesymphony.org/about/orchestra-conductors/bradley-mansell/",title="Cello"))
data <- rbind(data,data.frame(section="Cello",name="Lynn Marie Peithman",link="https://www.nashvillesymphony.org/about/orchestra-conductors/lynn-marie-peithman/",title="Cello"))
data <- rbind(data,data.frame(section="Cello",name="Stephen Drake",link="https://www.nashvillesymphony.org/about/meet-our-musicians/stephen-drake/",title="Cello"))
data <- rbind(data,data.frame(section="Cello",name="Christopher Stenstrom",link="https://www.nashvillesymphony.org/about/orchestra-conductors/christopher-stenstrom/",title="Cello"))
data <- rbind(data,data.frame(section="Cello",name="Keith Nicholas",link="https://www.nashvillesymphony.org/about/orchestra-conductors/keith-nicholas/",title="Cello"))
data <- rbind(data,data.frame(section="Cello",name="Xiao-Fan Zhang",link="https://www.nashvillesymphony.org/about/orchestra-conductors/xiao-fan-zhang/",title="Cello"))
data <- rbind(data,data.frame(section="Bass",name="Joel Reist",link="https://www.nashvillesymphony.org/about/orchestra-conductors/joel-reist/",title="Principal"))
data <- rbind(data,data.frame(section="Bass",name="Glen Wanner",link="https://www.nashvillesymphony.org/about/orchestra-conductors/glen-wanner/",title="Assistant Principal"))
data <- rbind(data,data.frame(section="Bass",name="Matthew Abramo",link="https://www.nashvillesymphony.org/about/orchestra-conductors/matt-abramo/",title="Bass"))
data <- rbind(data,data.frame(section="Bass",name="Evan Bish",link=NA,title="Bass"))
data <- rbind(data,data.frame(section="Bass",name="Kevin Jablonski",link="https://www.nashvillesymphony.org/about/orchestra-conductors/kevin-jablonski/",title="Bass"))
data <- rbind(data,data.frame(section="Bass",name="Katherine Munagian",link="https://www.nashvillesymphony.org/about/orchestra-conductors/katherine-munagian/",title="Bass"))
data <- rbind(data,data.frame(section="Flute",name="Erik Gratton",link="https://www.nashvillesymphony.org/about/orchestra-conductors/%C3%A9rik-gratton/",title="Principal"))
data <- rbind(data,data.frame(section="Flute",name="Leslie Fagan",link="https://www.nashvillesymphony.org/about/orchestra-conductors/leslie-fagan/",title="Assistant Principal"))
data <- rbind(data,data.frame(section="Piccolo",name="Gloria Yun",link="https://www.nashvillesymphony.org/about/orchestra-conductors/gloria-yun/",title="Piccolo"))
data <- rbind(data,data.frame(section="Oboe",name="Titus Underwood",link="https://www.nashvillesymphony.org/about/orchestra-conductors/titus-underwood/",title="Principal"))
data <- rbind(data,data.frame(section="Oboe",name="Ellen Menking",link="https://www.nashvillesymphony.org/about/orchestra-conductors/ellen-menking/",title="Assistant Principal"))
data <- rbind(data,data.frame(section="English Horn",name="Tamara Benitez-Winston",link=NA,title="English Horn"))
data <- rbind(data,data.frame(section="English Horn",name="Roger Wiesmeyer",link="https://www.nashvillesymphony.org/about/orchestra-conductors/roger-wiesmeyer/",title="English Horn"))
data <- rbind(data,data.frame(section="Clarinet",name="Katherine Kohler",link="https://www.nashvillesymphony.org/about/orchestra-conductors/katherine-kohler/",title="Acting Principal"))
data <- rbind(data,data.frame(section="Clarinet",name="Theresa Zick",link=NA,title="Acting Assistant Principal"))
data <- rbind(data,data.frame(section="Bass Clarinet",name="Daniel Lochrie",link="https://www.nashvillesymphony.org/about/orchestra-conductors/daniel-lochrie/",title="Bass Clarinet"))
data <- rbind(data,data.frame(section="Bassoon",name="Julia Harguindey",link="https://www.nashvillesymphony.org/about/orchestra-conductors/julia-harguindey/",title="Principal"))
data <- rbind(data,data.frame(section="Bassoon",name="Dawn Hartley",link="https://www.nashvillesymphony.org/about/orchestra-conductors/dawn-hartley/",title="Assistant Principal"))
data <- rbind(data,data.frame(section="Contrabassoon",name="Gil Perel",link="https://www.nashvillesymphony.org/about/orchestra-conductors/gil-perel/",title="Contrabassoon"))
data <- rbind(data,data.frame(section="Horn",name="Leslie Norton",link="https://www.nashvillesymphony.org/about/orchestra-conductors/leslie-norton/",title="Principal"))
data <- rbind(data,data.frame(section="Horn",name="Beth Beeson",link="https://www.nashvillesymphony.org/about/orchestra-conductors/beth-beeson/",title="Horn"))
data <- rbind(data,data.frame(section="Horn",name="Patrick Walle",link="https://www.nashvillesymphony.org/about/orchestra-conductors/patrick-walle/",title="Associate Principal"))
data <- rbind(data,data.frame(section="Horn",name="Anna Spina",link=NA,title="Horn"))
data <- rbind(data,data.frame(section="Horn",name="Hunter Sholar",link="https://www.nashvillesymphony.org/about/orchestra-conductors/hunter-sholar/",title="Horn"))
data <- rbind(data,data.frame(section="Horn",name="Radu V. Rusu",link="https://www.nashvillesymphony.org/about/orchestra-conductors/radu-v-rusu/",title="Assistant Principal"))
data <- rbind(data,data.frame(section="Trumpet",name="Shea Kelsay",link=NA,title="Acting Principal"))
data <- rbind(data,data.frame(section="Trumpet",name="Patrick Kunkee",link="https://www.nashvillesymphony.org/about/orchestra-conductors/patrick-kunkee/",title="Co-Principal"))
data <- rbind(data,data.frame(section="Trumpet",name="Alexander Blazek",link="https://www.nashvillesymphony.org/about/meet-our-musicians/alec-blazek/",title="Trumpet"))
data <- rbind(data,data.frame(section="Trombone",name="Paul Jenkins",link="https://www.nashvillesymphony.org/about/orchestra-conductors/paul-jenkins/",title="Principal"))
data <- rbind(data,data.frame(section="Trombone",name="Derek Hawkes",link="https://www.nashvillesymphony.org/about/orchestra-conductors/derek-hawkes/",title="Assistant Principal"))
data <- rbind(data,data.frame(section="Tuba",name="Gilbert Long",link="https://www.nashvillesymphony.org/about/orchestra-conductors/gilbert-long/",title="Principal"))
data <- rbind(data,data.frame(section="Timpani",name="Joshua Hickman",link="https://www.nashvillesymphony.org/about/orchestra-conductors/joshua-hickman/",title="Principal"))
data <- rbind(data,data.frame(section="Percussion",name="Sam Bacco",link="https://www.nashvillesymphony.org/about/orchestra-conductors/sam-bacco/",title="Principal"))
data <- rbind(data,data.frame(section="Percussion",name="Richard Graber",link="https://www.nashvillesymphony.org/about/orchestra-conductors/richard-graber/",title="Assistant Principal"))
data <- rbind(data,data.frame(section="Percussion",name="Chris Norton",link=NA,title="Acting Assistant Principal"))
data <- rbind(data,data.frame(section="Harp",name="Licia Jaskunas",link="https://www.nashvillesymphony.org/about/orchestra-conductors/licia-jaskunas/",title="Principal"))
data <- rbind(data,data.frame(section="Keyboard",name="Robert Marler",link="https://www.nashvillesymphony.org/about/orchestra-conductors/robert-marler/",title="Principal"))

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
orchestra <- "Nashville Symphony"
data <- cbind(orchestra = orchestra, data)


write.csv(data, file = paste0("~/Desktop/orchestra research data/CSVs/",orchestra,".csv"))
















# 
# table <- read_html(url) %>% html_nodes("td") %>% html_text2()
# table <- str_remove_all(table, "\\*|\\◆")
# split1 <- str_split(table[1], "\\n")
# split1 <- split1[[1]]
# split2 <- str_split(table[2], "\\n")
# split2 <- split2[[1]]
# split <- c(split1, split2)
# split <- split[str_detect(split,"")]
# split <- split[1:82]
# 
# partialNames <- read_html(url) %>% html_nodes("td") %>% html_nodes("a") %>% html_text()
# partialNames <- str_remove_all(partialNames, "\\◆")
# partialNames <- partialNames[str_detect(partialNames,"")]
# partialNames <- str_trim(partialNames)
# hrefList <- read_html(url) %>% html_nodes("td") %>% html_nodes("a")
# 
# section = ""
# title = ""
# for (i in 1:length(split)){
#   title <- section
#   link = NA
#   name = ""
#   while(str_length(split[i])!=0){
#     if(str_starts(split[i], "First Violin|Second Violin|Viola|Cello|Bass|Flute|Piccolo|Oboe|Clarinet|E-flat Clarinet|Bass Clarinet|Bassoon|Contrabassoon|Trumpet|Trombone|English Horn|Tuba|Horn|Timpani|Percussion|Harp|Keyboard")){
#       section <- split[i]
#       title <- section
#       split[i] <- ""
#     }
#     else{
#       if(str_detect(split[i], "Chair")){
#         chairIndices <- str_locate(split[i], "Chair")
#         chairIndex <- chairIndices[1,2]
#         commaIndices <- str_locate_all(str_sub(split[i], 1, chairIndex), ",")
#         commaIndices <- commaIndices[[1]]
#         commaIndex <- commaIndices[(nrow(commaIndices)),2]
#         split[i] <- str_c(str_sub(split[i], 1, commaIndex-1), str_sub(split[i], chairIndex, str_length(split[i])))
#       }
#       for(j in 1:length(partialNames)){
#         if(str_detect(split[i], partialNames[j])){
#           nameIndices <- str_locate(split[i], partialNames[j])
#           nameIndex1 <- nameIndices[1,1]
#           nameIndex2 <- nameIndices[1,2]
#           name = str_sub(split[i], nameIndex1, nameIndex2)
#           for(k in 1:length(hrefList)){
#             if(str_detect((hrefList[k] %>% html_text()), name)){
#               link = hrefList[k] %>% html_attr("href")
#               link <- str_c("https://www.nashvillesymphony.org", link)
#             }
#           }
#           split[i] <- str_sub(split[i], nameIndex2+1, str_length(split[i])) 
#           if(!is_empty(split[i]) && str_starts(split[i], ",")){
#             leadIndices <- str_locate(split[i], "Concertmaster|Principal")
#             leadIndex <- leadIndices[1,2]
#             title = str_sub(split[i], 3, leadIndex)
#             split[i] <- str_sub(split[i], leadIndex+1, str_length(split[i]))
#           }
#           break
#         }
#       }
#       if(is.na(name)){
#         if(str_detect(split[i], "Concertmaster|Principal")){
#           leadIndices <- str_locate(split[i], "Concertmaster|Principal")
#           leadIndex <- leadIndices[1,2]
#           commaIndices <- str_locate_all(str_sub(split[i], 1, leadIndex), ",")
#           commaIndices <- commaIndices[[1]]
#           commaIndex <- commaIndices[(nrow(commaIndices)),2]
#           title = str_sub(split[i], commaIndex+2, leadIndex)
#           name = str_sub(split[i], 1, commaIndex-1)
#           if(leadIndex<length(split[i]) && str_sub(split[i], leadIndex+1, (leadIndex+1))=="+"){
#             split[i] <- str_sub(split[i], leadIndex+2, str_length(split[i]))
#           } else {
#             split[i] <- str_sub(split[i], leadIndex+1, str_length(split[i]))
#           }
#         } else {
#           plusIndices <- str_locate(split[i], "\\+")
#           plusIndex <- plusIndices[1,1]
#           name = str_sub(split[i], 1, plusIndex-1)
#           split[i] <- str_sub(split[i], (plusIndex+1), str_length(split[i]))
#         }
#       }
#       split[i] <- str_trim(split[i])
#       if(str_starts(split[i], "\\/|\\+| ")){
#         split[i] <- ""
#       }
#       data <- rbind(data,data.frame(section=section,name=name,link=link,title=title))
#     }
#   }
# }
