library(tidyverse)
library(gganimate)
library(paletteer)
GenArt_ellipse = function(n, from , by = 1 , rand1, rand2, rand3) {
  dataframe = data.frame(t = seq(from,n,by)) %>%
    mutate(
      x = sin(t+rand1) + sin(t + rand2) * exp(rand3)^-rand1,
      y = cos(t-rand3) + cos(t - rand3) * exp(rand2)^-rand1,
      z = sin(t+rand3) +tan(t+rand2) * exp(rand1)^-rand2
    )
  
}


GenArt_ellipse(2000, 1, by = 1, 5, 68, 200) -> dat

plot(dat)

paletteer_c("grDevices::topo.colors", 30) 
paletteer_c("ggthemes::Classic Red-Blue", 30)

paletteer_c("grDevices::Purple-Yellow", 30)   -> cols

ggplot(dat) +
  geom_jitter(aes( x = t, y = x , color = z, alpha = t*x), width = 50, show.legend = FALSE, size = 0.7) +
  geom_jitter(aes( x = t, y = x *y, color = z, alpha = t), width = 50, show.legend = FALSE,size = 0.7) +
  geom_jitter(aes( x = t, y = x *y, color = z, alpha = t), width = 50, show.legend = FALSE,size = 0.7) +
  scale_color_gradientn(colors = cols)+
# 
  coord_polar() +
  theme_void() +
  theme(plot.background = element_rect(color = "black", fill = "black"))-> plot
plot

plot + transition_reveal(along = t*x)  + ease_aes("circular-in") +  shadow_wake(wake_length = 0.01, alpha = 0.5) -> anim
animate(anim, nframes = 100)


animate(anim, nframes = 200, width = 6, height = 6, units = "in", fps = 15, duration = 15, res = 150) -> anim_fin
anim_save(anim_fin, 
          path = r"(your_directory)",
          filename = "brush.gif")
