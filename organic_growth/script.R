library(tidyverse)
library(tmaptools)
library(viridisLite)
library(gganimate)

x = rnorm(100, 50, 50) *sin(log(exp(10)))
y = runif(100, 10, 90) *cos(log(exp(10)))

data.frame(x,y) -> dat

dat$cat = "cat"

ggplot(dat, aes(x = x, y = y, color = x)) +
  geom_point(show.legend = FALSE) +
  geom_segment(xend = 0, yend = 0, show.legend = FALSE)+
  # geom_polygon() +
  coord_polar() +
  scale_color_gradientn(colours = c("#e1ff00", "#cef218", "#bae623", "#a7d92b", "#93cd30", "#7fc034", "#6bb437", "#55a83a", "#3d9c3c", "#1c903d"))+
  theme_void() +
  theme(plot.background = element_rect(fill = "white", color = "white")) -> magma_segm
magma_segm







magma_segm + transition_reveal(along = sin(y)) +
  shadow_wake(wake_length = 0.05, alpha = 0.5)+
  ease_aes("sine-in-out")-> anim
animate(anim, nframes = 200, width = 6, height = 6, units = "in", fps = 15, duration = 15, res = 150) -> anim_fin
anim_save(anim_fin, 
          path = r"(C:\Users\tobia\Desktop\dataviz\genart\animation)",
          filename = "organic_growth.gif")
