
# plotting NO3 data - forest plot 

data <- read.table("All-Data-inRform.txt", sep = "\t", header=T)

sapply(data, is.numeric)

require(dplyr)
library(ggplot2)



Avs <- data %>% 
  group_by(timepoint, Treatment) %>%
  summarise(av = mean(NO3), 
            sdv = sd(NO3),
            Var = var(NO3),
            Tp = first(Tmt),
            phs = first(Phase),
            total = n())


# work out mean of control throughout. 
dd <- subset(Avs, Treatment=="Control")

DD = dd[,c(3,4)]
sapply(DD, function(cl) list(means=mean(cl,na.rm=TRUE), sds=sd(cl,na.rm=TRUE)))
# use output of this for vertical line mean of control 
# = 1.1

# order you want timepoints to occur
Avs[["timepoint"]] <- setFactorOrder(Avs[["timepoint"]], c("T0", "T1", "T2", "T3", "T4", "T5","T6","T7", "T8", "T9","T10","T11","T12", "T13"))

# order of treatments. 
Avs[["Treatment"]] <- setFactorOrder(Avs[["Treatment"]], c("Control", "Slurry", "Flood", "Flood+Slurry"))
# 
# data[["Phase2"]] <- setFactorOrder(data[["Phase2"]], c("NoFlood", "Flooded", "Recovery")) 
# 
# data[["Phase3"]] <- setFactorOrder(data[["Phase3"]], c("PreFlood", "Flood", "Recovery")) 



#### and now plot :
p <- ggplot(Avs, aes(x=timepoint, y=av, ymin=av-sdv, ymax=av+sdv))+
  geom_pointrange(size=0.75)+
  geom_hline(yintercept = 1.1, linetype=2)+ # y intercept= Av of all control resp
  coord_flip(ylim = c(0, 10)) +
  xlab('Time Point')+ 
  geom_point(colour="black", shape=21, size = 10) +
  aes(fill = factor(Treatment)) + 
  scale_fill_manual(values=c("black", "chocolate4", "slateblue", "olivedrab"))
p

p1 = p + ylab(expression(paste('Nitrate concentration (g ', N-NO[3],' ', g^-1, 'soil ) ')))


# legend on side with heading
p2 <- p1 + theme_bw() + 
  theme(axis.text.y=element_text(size=16, colour="black"),
        axis.text.x=element_text(size=16, colour="black"),
        axis.title.x=element_text(size=16, colour="black"),
        legend.text = element_text(size=16),
        legend.title = element_text(size=17),
        axis.title.y=element_blank())+
  labs(fill="    Treatment") 
p2


# put legend inside plot 
PDRplot = p2 + theme(legend.justification = c(1, 1), legend.position = c(1, 1),
                     legend.background = element_rect(colour = "black", fill = "white"))

PDRplot

