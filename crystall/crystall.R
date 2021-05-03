library(tidyverse)
library(tmaptools)
library(viridisLite)
library(ambient)
library(ggforce)
library(ggalt)


dataframe = data.frame(t = seq(1, 50, 1)) %>%
  mutate(
    x = runif(50, -20, 30),
    y = runif(50, -200, 200) ,
    z = rnorm(50,0, 100) ,
    r = rnorm(50, 0, 500),
    cat = "cat"
  )
dataframe

ggplot(dataframe)+
  # geom_point(aes(x*z, y*z, size = t*z, color = z)
  #            ) +

  geom_polygon(aes(x*r, y*r, fill = r), size = 0.5, alpha = 0.7, fill = "transparent", color = "white")+
 geom_polygon(aes(-x*r, y*r, fill = r), alpha = 0.3)+
  
  
  geom_polygon(aes(x*y, -y*r, fill = r), size = 1, alpha = 0.7)+

  geom_polygon(aes(x*r, -y*r, fill = r), size = 1, alpha = 0.2)+
  
  scale_size_continuous(range = c(0.5,7))+
  scale_fill_gradient2(low = "black", high = "cyan")+
  # scale_fill_gradient2(colours = pal)+
  theme_void()+
  theme(plot.background = element_rect(fill = "black"),
        panel.background = element_rect(fill = "black", color = "black"),
        legend.position = "none") -> plot

plot

# library(gganimate)

plot + transition_reveal(along = x)+ ease_aes("elastic-in-out") +
  shadow_wake(wake_length = 0.05, alpha =0.1) + enter_fade(alpha =0.5) + enter_fade(alpha =0.5) +
  enter_fade(alpha =0.5)-> anim

animate(anim, nframes = 10)

animate(anim,res = 150, fps = 15, nframes = 200, width = 6, height = 6 , units = "in",
        duration = 10) -> anim_fin

anim_save(anim_fin, 
          path = r"(C:\Users\tobia\Desktop\dataviz\genart\animation)",
          filename = "crystall.gif")

c("#490184", "#5c0176", "#6b016c", "#770163", "#82015b", "#8d0153", "#97014b", "#a10144", "#aa003d", "#b40036", "#bd0030", "#c70029", "#d00022", "#da001b", "#e30014", "#ec000e", "#f60007", "#ff0000") -> pal
