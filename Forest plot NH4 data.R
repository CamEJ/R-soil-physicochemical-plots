## Forest plot NH4 data


D1 <- read.table(file="nh4-FOREST.txt", header=T, sep='\t')

D1[["Treatment"]] <- setFactorOrder(D1[["Treatment"]], c("Control", "Slurry", "Flood", "Flood+Slurry"))
D1[["timepoint"]] <- setFactorOrder(D1[["timepoint"]], c("T0", "T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8", "T9", "T10", "T11", "T12", "T13"))


# and again so it keeps treatments in correct order in legend. 

p <- ggplot(D1, aes(x=timepoint, y=NH4_m, ymin=NH4_m-NH4_sdev, ymax=NH4_m+NH4_sdev))+
  geom_pointrange(size=0.75)+
  geom_hline(yintercept = 2.79, linetype=2)+ # y intercept= Av of all control resp
  coord_flip(ylim = c(0.12, 100))+
  xlab('Time Point')+
  geom_point(colour="black", shape=21, size = 10) +
  aes(fill = factor(Treatment)) + 
  scale_fill_manual(values=c("black", "chocolate4", "slateblue", "olivedrab"))
p

# legend on side with heading
p2 <- p + theme_bw() + 
  theme(axis.text.y=element_text(size=16, colour="black"),
        axis.text.x=element_text(size=16, colour="black"),
        axis.title.x=element_text(size=16, colour="black"),
        legend.text = element_text(size=16),
        legend.title = element_text(size=17),
        axis.title.y=element_blank())+
  labs(fill="    Treatment") +
  ylab(expression(paste('Ammonium concentration (g ', NH[4],' ', kg^-1, ' soil) '))) 
  
p2


p2 <- p + theme_bw() + 
  theme(axis.text.y=element_text(size=17, colour="black")) +
  theme(axis.text.x=element_text(size=16, colour="black"))+
  #theme(legend.title=element_text(name="Treatment"))
  theme(legend.text = element_text(size=15)) +
  theme(legend.title = element_text(size=16)) +
  labs(fill="Treatment") + 
  ylab(expression(paste('Ammonium concentration (g ', NH[4],' ', kg^-1, ' soil) '))) +
theme(axis.title.x=element_text(size=16, colour = "black"))+
      theme(axis.title.y=element_blank())
# y="Ammonium concentration (g NH4 / kg soil)") 
p2

p2 + theme(axis.title=element_text(size=14))


# put legend inside plot 
PDRplot = p2 + theme(legend.justification = c(1, 1), legend.position = c(1, 1),
                     legend.background = element_rect(colour = "black", fill = "white"))

PDRplot
