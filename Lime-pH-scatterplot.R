# Scatter plots

# Example data: "scatter.txt" (tab separated)
Week	pH	Treatment	Location
0	5.58	Zero	Soil
2	5.245	Zero	Rhizo
4	5	Zero	Soil
5	4.9025	Zero	Soil
0	4.9	Zero	Rhizo
2	4.85	Zero	Rhizo
4	4.845	Zero	Rhizo
5	5.1375	Zero	Soil
0	5.17	High	Soil
2	5.0425	High	Soil
4	5.3025	High	Rhizo
5	5.155	High	Rhizo
6	5.6275	High	Soil

poo <-read.table("phAll.txt", header = TRUE, sep='\t')

# ie four variables: week, pH, treatment, location

# libraries needed:

library(ggplot2)

# read in table from wkdir
data <- read.table("scatter.txt", header = TRUE, , sep='\t')

k <- ggplot(poo, aes(x=Week,y=pH)) + 
  geom_point(aes(color=Treatment),
             size = 5) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 10)) 

k # print and check

# change colours 
k2 <- k + theme_bw() + 
  theme(text = element_text(size=18, color = "black")) 
  

## now add axis labels and title   
#k3 <- k2 +  labs(x = "Week of trial") 

## Editing title to make space beneath it and to change size and font face

#k2 + theme(plot.title = element_text(size=12, face="bold", vjust=2)) 

library(grid)

 K3 <- k2 + theme(axis.text.x=element_text(size=14, vjust=0.5, color = "black"), 
      axis.text.y=element_text(size=14, vjust=0.5, color = "black"),
      axis.title.x=element_text(size=16, vjust=0.25, face = "bold", color="black"),
      axis.title.y=element_text(size=16, vjust=1, face = "bold", color="black"),
      legend.title=element_text(size=16, vjust=1),
      legend.text=element_text(size=16, vjust=0.5))
     
   k4 <- K3 +  guides(color = guide_legend(override.aes = list(size=7))) 
    
  k5 <- k4 +   theme(legend.key = element_rect(size = 5),
          legend.key.size = unit(1.5, 'lines')) 
   k5
   
  
  k6 <- k5 + labs(color="   Lime\nTreatment\n")
k6  


      
      
      
      
      #legend.key.size=unit(2, "cm") )
     
      
      
      #guides(fill = guide_legend(override.aes = list(size=16))) 
      


