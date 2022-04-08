library(data.table)
files <- Sys.glob("../data/*.csv")

alldat <- NULL
for(f in files){
  tempdat <- fread(f)
  alldat <- rbind(alldat, tempdat, fill = T)
}

names(alldat[, c(125:142, 157)])
setnames(alldat, c("Timing under risk round 1 on time", 
                   "Timing under risk round 1 times to early", 
                   "Timing under risk round 1 times to late",
                   "Timing under risk round 2 on time", 
                   "Timing under risk round 2 times to early", 
                   "Timing under risk round 2 times to late") ,
         c("tur_1_corr",
           "tur_1_early",
           "tur_1_late",
           "tur_2_corr",
           "tur_2_early",
           "tur_2_late"))

turdat <- alldat[!is.na(tur_1_corr) & !is.na(tur_2_corr)]

turdat <- turdat[, .(tur_1_early = mean(tur_1_early), 
                     tur_2_early = mean(tur_2_early),
                     tur_1_corr = mean(tur_1_corr),
                     tur_2_corr = mean(tur_2_corr),
                     tur_1_late = mean(tur_1_late), 
                     tur_2_late = mean(tur_2_late))]

