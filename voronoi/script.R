library(tidyverse)
library(tmaptools)
library(viridisLite)
library(ambient)
library(ggforce)
library(ggalt)
library(gganimate)



dataframe = data.frame(t = seq(1, 500, 1)) %>%
  mutate(
    x = runif(500, -20, 30),
    y = runif(500, 0, 81),
    z = rnorm(500,0, 200),
    state = rep(c('a', 'b', "c", "d", "e",
                  "f", "g", "h", "i", "j"), c(50, 50, 50, 50, 50,
                                              50, 50, 50, 50, 50)),
    cat = "cat"
  )
dataframe



#play SQRT!!
ggplot(data = dataframe) +
  geom_voronoi_tile(aes(x = x*t, y = y*t, color = t), fill = "transparent", show.legend = FALSE)+
  scale_color_gradientn(colors =get_brewer_pal("Blues", n = 20, contrast = c(0.2, 1))) +
  theme_void() +
  theme(plot.background = element_rect(color = "black", fill = "black"))  -> SQRT
SQRT

SQRT + transition_states(state) + ease_aes("circular-in-out")  -> anim
animate(anim, fps = 15, nframes = 10, duration = 20, res = 150, width = 6, height = 6 , units = "in",
        renderer = gifski_renderer()) -> anim_fin
anim_save(anim_fin, 
          path = r"(C:\Users\tobia\Desktop\dataviz\genart\animation)",
          filename = "voronoi_scaled.gif")
