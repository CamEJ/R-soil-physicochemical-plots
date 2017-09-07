
# plotting PDR data - forest plot 

data <- read.table("All-Data-inRform.txt", sep = "\t", header=T)

sapply(data, is.numeric)

require(dplyr)
library(ggplot2)



AvsPDR <- data %>% 
  group_by(timepoint, Treatment) %>%
  summarise(av = mean(PDR), 
            sdv = sd(PDR),
            Var = var(PDR),
            Tp = first(Tmt),
            phs = first(Phase),
            total = n())

# work out mean of control throughout. 
dd <- subset(AvsPDR, Treatment=="Control")

DD = dd[,c(3,4)]
sapply(DD, function(cl) list(means=mean(cl,na.rm=TRUE), sds=sd(cl,na.rm=TRUE)))
# use output of this for vertical line mean of control 

# order you want timepoints to occur
AvsPDR[["timepoint"]] <- setFactorOrder(AvsPDR[["timepoint"]], c("T0", "T1", "T2", "T3", "T4", "T5","T6","T7", "T8", "T9","T10","T11","T12", "T13"))

# order of treatments. 
AvsPDR[["Treatment"]] <- setFactorOrder(AvsPDR[["Treatment"]], c("Control", "Slurry", "Flood", "Flood+Slurry"))




#### and now plot :
p <- ggplot(AvsPDR, aes(x=timepoint, y=av, ymin=av-sdv, ymax=av+sdv))+
  geom_pointrange(size=0.75)+
  geom_hline(yintercept = 226.5, linetype=2)+ # y intercept= Av of all control resp
  coord_flip(ylim = c(0, 1000)) +
  xlab('Time Point')+ 
  ylab())) +
  geom_point(colour="black", shape=21, size = 10) +
  aes(fill = factor(Treatment)) + 
  scale_fill_manual(values=c("black", "chocolate4", "slateblue", "olivedrab"))
p

p1 = p + ylab(expression(paste('PDR (', mu, 'g ', N,' kg ', soil^-1, 'soil ', hr^-1, ')' )))


# legend on side with heading
p2 <- p1 + theme_bw() + 
  theme(axis.text.y=element_text(size=16, colour="black", hjust=0),
        axis.text.x=element_text(size=16, colour="black"),
        axis.title.x=element_text(size=16, colour="black"),
        legend.text = element_text(size=16),
        legend.title = element_text(size=17),
        axis.title.y=element_blank())+
  labs(fill="Treatment") 
p2

