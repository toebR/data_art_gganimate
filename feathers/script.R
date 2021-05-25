library(tidyverse)
library(gganimate)
library(paletteer)
library(gganimate)
GenArt_ellipse = function(n, from , by = 1 , rand1, rand2, rand3) {
  dataframe = data.frame(t = seq(from,n,by)) %>%
    mutate(
      x = sin(t+rand1) + sin(t + rand2) * exp(rand3)^-rand1,
      y = cos(t-rand3) + cos(t - rand3) * exp(rand2)^-rand1,
      z = sin(t+rand3) +tan(t+rand2) * exp(rand1)^-rand2
    )
  
}

dat$state <-  rep(c('a', 'b', "c", "d", "e", "f", "g", "h", "i", "j"),
                  c(100, 100, 100, 100, 100, 100, 100, 100, 100, 100))

GenArt_ellipse(1000, 1, by = 1, 5, 68, 200) -> dat

plot(dat)

ggplot(dat)+
  geom_curve(aes(x = t, xend = y*z, y = y*t, yend = x*y, color = z*x, alpha = sin(z*x)), show.legend = FALSE, size = 0.5)+
  geom_curve(aes(x = -t, xend = -y*z, y = -y*t, yend = -x*y, color = z*x, , alpha = sin(z*y)), show.legend = FALSE, size = 0.5)+
  scale_color_gradientn(colors = paletteer_c("grDevices::Spectral", 30) ) +
  theme_void() + theme(plot.background = element_rect(fill = "black", color = "black")) -> plot
plot
plot + transition_reveal(along = sin(z)*t) +
  shadow_wake(wake_length = 0.1) +
ease_aes("circular-in-out") -> anim




animate(anim, nframes = 200, width = 6, height =6, units = "in", fps = 15, duration = 10, res = 150) -> anim_fin
anim_save(anim_fin, 
          path = r"(your_directory)",
          filename = "feathers.gif")
