
## box and violin plots PNR data


data <- read.table("All-Data-inRform.txt", sep = "\t", header=T)

require(dplyr)
library(ggplot2)

data[["Treatment"]] <- setFactorOrder(data[["Treatment"]], c("Control", "Slurry", "Flood", "Flood+Slurry"))

data[["Phase2"]] <- setFactorOrder(data[["Phase2"]], c("NoFlood", "Flooded", "Recovery")) 
data[["timepoint"]] <- setFactorOrder(data[["timepoint"]], c("T0", "T1", "T2", "T3", "T4", "T5","T6","T7", "T8", "T9","T10","T11","T12", "T13"))


ggplot(data, aes(as.factor(Phase2), PNR, fill = factor(Treatment))) +
  
  ## + geom_boxplot so it knows what type of plot
  
  geom_violin() +
  scale_fill_manual(name = "    Treatment\n", values = c("black", "chocolate4", "slateblue", "olivedrab")) +
  
  ## theme_bw() to make background white
  
  theme_bw()   + theme(axis.text.x=element_text(size=15, vjust=0.5, colour="black"), 
                       axis.text.y=element_text(size=14, vjust=0.5, colour="black"),
                       axis.title.x=element_blank(),
                       axis.title.y=element_text(size=16, vjust=1, face = "bold"),
                       legend.title=element_text(size=17, vjust=1),
                       legend.text=element_text(size=15, vjust=0.5),
                       legend.key.size=unit(1.5, "cm")
  ) +
  labs(y="PNR rates") +
  ylab(expression(paste('mean PNR rate (', mu, 'g ', N-NO[-2],' ', g^-1, 'soil ', hr^-1, ')' )))
  


# saved as PNR-by-Phase-violin.tiff


ggplot(data, aes(as.factor(Phase2), PNR, fill = factor(Treatment))) +
  
  ## + geom_boxplot so it knows what type of plot
  
  geom_boxplot(colour="black") +
  scale_fill_manual(name = "    Treatment\n", values = c("black", "chocolate4", "slateblue", "olivedrab")) +
  
  ## theme_bw() to make background white
  
  theme_bw()   + theme(axis.text.x=element_text(size=15, vjust=0.5, colour="black"), 
                       axis.text.y=element_text(size=14, vjust=0.5, colour="black"),
                       axis.title.x=element_blank(),
                       axis.title.y=element_text(size=16, vjust=1, face = "bold"),
                       legend.title=element_text(size=17, vjust=1),
                       legend.text=element_text(size=15, vjust=0.5),
                       legend.key.size=unit(1.5, "cm")
  ) +
  labs(y="Mean PNR rates")


# saved as PNR-by-Phase-boxPlot.tiff



## PNR for all, facet wrapped by timepoint. 

ggplot(data, aes(as.factor(Treatment), PNR, fill = factor(Treatment))) +
  
  ## + geom_boxplot so it knows what type of plot
  
  geom_boxplot(colour="black") +
  facet_wrap(~timepoint, ncol = 3) +
  scale_fill_manual(name = "Treatment", values = c("black", "chocolate4", "slateblue", "olivedrab")) +
  
  ## theme_bw() to make background white
  
  theme_bw()   + theme(axis.text.x=element_blank(), 
                       axis.text.y=element_text(size=14, vjust=0.5, colour="black"),
                       axis.title.x=element_blank(),
                       axis.title.y=element_text(size=16, vjust=1, face = "bold"),
                       legend.title=element_text(size=17, vjust=1),
                       legend.text=element_text(size=15, vjust=0.5),
                       legend.key.size=unit(1.5, "cm"),
                       axis.ticks.x=element_blank(),
                       legend.position="top",
  strip.text.x = element_text(size = 12, colour = "black"),# change font of facet label
strip.background =  element_rect(fill = "white") ) + # remove grey backgroup of facet label

  ylab(expression(paste('PNR rate (', mu, 'g ', N-NO[-2],' ', g^-1, 'soil ', hr^-1, ')' )))



# saved as PNR-byTp_boxplots.tiff
