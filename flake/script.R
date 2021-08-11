library(tidyverse)
library(gganimate)
library(paletteer)
GenArt_ellipse = function(n, from , by = 1 , rand1, rand2, rand3) {
  dataframe = data.frame(t = seq(from,n,by)) %>%
    mutate(
      x = cos(t+rand1) + sin(t + rand2) * exp(rand3)^-rand1,
      y = sin(t-rand3) + cos(t - rand3) * exp(rand2)^-rand1,
      z = sin(t+rand3) +tan(t+rand2) * exp(rand1)^-rand2
    )
  
}


GenArt_ellipse(1000, 5, by = 2, 5, 60, 3) -> dat

plot(dat)

paletteer_c("grDevices::topo.colors", 30) 
paletteer_c("ggthemes::Classic Red-Blue", 30)

paletteer_c("grDevices::Purple-Yellow", 30)   -> cols

ggplot(dat) +

  geom_count(aes(x = x, y = y*y, color = z*z), size =1, show.legend = FALSE)+
  geom_count(aes(x = z, y = exp(x*x), color = z*z), size =1, show.legend = FALSE)+
  geom_count(aes(x = x, y = -exp(z*z), color = z*z), size =1, show.legend = FALSE)+
  geom_count(aes(x = exp(x*x), y = z*z, color = z*z), size =1, show.legend = FALSE)+
  geom_count(aes(x = -exp(x*x), y = exp(z*y), color = z*z), size =1, show.legend = FALSE)+
  geom_count(aes(x = exp(y*z), y = -exp(z*z), color = z*z), size =1, show.legend = FALSE)+
  geom_count(aes(x = -exp(x*x), y = -z*y, color = z*z), size =1, show.legend = FALSE)+


  scale_color_gradientn(colors = cols)+
  theme_void() +
  theme(plot.background = element_rect(color = "black", fill = "black"))-> plot
plot

plot + transition_reveal(along = exp(x))  + ease_aes("circular-in") +  shadow_wake(wake_length = 0.01, alpha = 0.5) -> anim
animate(anim, nframes = 50)


animate(anim, nframes = 200, width = 6, height = 6, units = "in", fps = 15, duration = 15, res = 150) -> anim_fin
anim_save(anim_fin, 
          path = r"(C:\Users\tobia\OneDrive\Desktop\dataviz\genart\animation\flake)",
          filename = "flake.gif")
