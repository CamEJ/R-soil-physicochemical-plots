## Forest plot NH4 data


D1 <- read.table(file="nh4-FOREST.txt", header=T, sep='\t')

D1$timepoint <- factor(D1$timepoint, levels = D1$timepoint)
# do this so it keeps time points in order
# don't worry too much about resulting warning message
D1$Treatment <- factor(D1$Treatment, levels = D1$Treatment)
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

p2 <- p + theme_bw() + 
  theme(axis.text.y=element_text(size=17, colour="black")) +
  theme(axis.text.x=element_text(size=16, colour="black"))+
  #theme(legend.title=element_text(name="Treatment"))
  theme(legend.text = element_text(size=15)) +
  theme(legend.title = element_text(size=16)) +
  labs(fill="Treatment") + 
       ylab(expression(paste('Ammonium concentration (g ', NH[4],' ', kg^-1, ' soil) '))) #+
  theme(axis.title.y=element_text(size=20))
        # y="Ammonium concentration (g NH4 / kg soil)") 
p2

p2 + theme(axis.title=element_text(size=14))
