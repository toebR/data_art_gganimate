library(tidyverse)
library(tmaptools)
library(viridisLite)
library(ambient)
library(here)
library(gganimate)

palette_explorer()


#R function to create a data frame with x, y, z
GenArt_ellipse = function(n, from , by = 1 , rand1, rand2, rand3) {
  dataframe = data.frame(t = seq(from,n,by)) %>%
    mutate(
      x = sin(t+rand1) + sin(t + rand2) * exp(rand3)^-rand1,
      y = cos(t-rand3) + cos(t - rand3) * exp(rand2)^-rand1,
      z = sin(t+rand3) +tan(t+rand2) * exp(rand1)^-rand2
    )
  
}
#apply function with chosen passed parameters
try = GenArt_ellipse(n = 2000, from = 1, by = 1, rand1 = 100, rand2 = 0.3, rand3 = 10)
#visual tranformation of the dataframe
try

plot(try)

ggplot(try)+
  geom_point(aes(x=t, y =y, color = z, size = -t*z, alpha = t))+
  geom_point(aes(x = t, y = z, color = z), alpha = 0.8) +
  scale_color_gradient2(low = "#034B61", mid = "#19B3B1", high = "#BC5F6A") + theme_void()+
  theme(plot.background = element_rect(fill = "black", color = "black"),
        panel.background = element_rect(fill ="black", color = "black"),
        legend.position = "none")-> p1




p1
p1 + transition_reveal(along = sin(t/z)) + ease_aes("sine-in-out") -> anim

animate(anim, nframes = 100, width = 5, height = 5, units = "in", fps = 20, duration = 7, res = 150, renderer = gifski_renderer()) -> anim_fin

anim_save(anim_fin, 
          path = paste0(here()),
          filename = "bubbles.gif")
