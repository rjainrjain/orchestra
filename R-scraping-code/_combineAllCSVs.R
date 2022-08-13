

orchestra <- c("Atlanta Symphony Orchestra", "Baltimore Symphony Orchestra", "Boston Symphony Orchestra", "Chicago Symphony Orchestra", "Cincinnati Symphony Orchestra", 
                "Dallas Symphony Orchestra", "Detroit Symphony Orchestra", "Houston Symphony Orchestra", "Indianapolis Symphony Orchestra", 
               "Kansas City Symphony", "Los Angeles Philharmonic", "Milwaukee Symphony Orchestra", "Minnesota Orchestra", "Nashville Symphony", "National Symphony Orchestra", 
               "New York Philharmonic", "Oregon Symphony", "Pacific Symphony",  "Pittsburgh Symphony Orchestra",  
               "San Diego Symphony", "San Francisco Symphony", "Seattle Symphony", "St. Louis Symphony Orchestra", "The Cleveland Orchestra", "The Philadelphia Orchestra", 
               "The Saint Paul Chamber Orchestra", "Utah Symphony")

data <- data.frame()


for(i in 1:length(orchestra)){
  file <- paste0("~/Desktop/orchestra research data/CSVs/",orchestra[i],".csv")
  data <- rbind(data, as.data.frame(read.csv(file)))
}

data <- data[,-1]

write.csv(data, "~/Desktop/orchestra research data/dataset.csv")