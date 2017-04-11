
# forest plots representing changes in litter decomp from control

# the data used here is from the 'water only' wells of the microresp,
# with each data point being an average of the three bio reps (microcosms)
# the data file used has 4 colums, here is the head:

#     ID    LitterDecomp treatment timepoint      pSd          
#1 Tmt1_T0 0.4723870      Tmt1        T0 0.001871706 
#2 Tmt2_T0 1.4472063      Tmt2        T0 0.303400466 
#3 Tmt1_T1 0.4625339      Tmt1        T1 0.003786029 
#4 Tmt2_T1 0.7242768      Tmt2        T1 0.056182498 
#5 Tmt1_T2 0.4819327      Tmt1        T2 0.004009777

# where pSd is the standard dev of the 3 bio reps

# the excel doc from which this data is taken is in litter decomp folder
# and a sheet in doc called 'LitterDeg-compliled

setwd("C:/Users/Camilla/Dropbox/Data & analysis/WP3 Slurry disturbance/R")


D1 <- read.table(file="LitterDecompForest.txt", header=T, sep='\t')

D1$timepoint <- factor(D1$timepoint, levels = D1$timepoint)
# do this so it keeps time points in order
# don't worry too much about resulting warning message
D1$Treatment <- factor(D1$Treatment, levels = D1$Treatment)
# and again so it keeps treatments in correct order in legend. 

p <- ggplot(D1, aes(x=timepoint, y=LitterDecomp, ymin=LitterDecomp-pSd, ymax=LitterDecomp+pSd))+
  geom_pointrange(size=0.75)+
  geom_hline(yintercept = 1.72, linetype=2)+ # y intercept= Av of all control resp
  coord_flip(ylim = c(0.12, 7))+
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
  labs(fill="Treatment") 
p2

