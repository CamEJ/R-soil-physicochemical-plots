# plotting soil moisture content line plot

library(data.table)
 # read in all data from soil weights excel sheet called R
# raw data still with 3 bio reps per tmt etc. 
Wt <-read.table("SoilWeights.txt", header = TRUE, sep='\t')

dt <- data.table(Wt)
# mean & sd per three bio reps
MC.data <- dt[,list(mean=mean(MC),sd=sd(MC)),by=ID]

# read in another table that matches
# ie will give metadata for the averages

Wt <-read.table("avMetadata-soil.txt", header = TRUE, sep='\t')

Wt$MCav <- MC.data$mean # add moisture data means to this
Wt$MCsd <- MC.data$sd # add moisture data sd to this
Wt$time <- factor(Wt$time, levels = Wt$time) # put time as factor so
# it doesnt try to re-order

# take a look
head(Wt)

## before plotting set theme to WP3 colours as usual. 
library(ggthemr)
# define 
WP3_colsA <- c("black", "chocolate4", "slateblue", "olivedrab")
# add background
WP3_cols <- c("#555555", WP3_colsA)

# define palette
WP3Cols <- define_palette(
  swatch = WP3_cols, # colours for plotting points and bars
  gradient = c(lower = WP3_cols[1L], upper = WP3_cols[2L]), #upper and lower colours for continuous colours
  background = "white" #defining a grey-ish background 
)

# set new col theme as current

ggthemr(WP3Cols)    


## now to plotting

# define limits for error bars
limits <- aes(ymax = MCav + MCsd, ymin=MCav - MCsd)

j <- ggplot(data=Wt, aes(x=time,y=MCav, group=Tmt, colour=Tmt)) +
  geom_line(size=1) +
  geom_point(size=4, shape=21) +
  ## add error bars
  geom_errorbar(limits, width=0.25) +
  theme_bw() +
  labs(colour="Treatment", y= "% Moisture Content", x = "") +
  guides(color = guide_legend(override.aes = list(size=5))) +
  theme(axis.text.x=element_text(size=12)) +
  theme(axis.text.y=element_text(size=12))

j




