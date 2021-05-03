library(tidyverse)
library(tmaptools)
library(viridisLite)
library(ambient)
library(ggforce)
library(ggalt)

# palette_explorer()
# 
# dir = "C:\\Users\\tobia\\OneDrive\\Desktop\\ownprojects\\R\\generativeArt"
# setwd(dir)

dataframe = data.frame(t = seq(1, 200, 1)) %>%
  mutate(
    x = runif(200, -20, 30),
    y = runif(200, 0, 81),
    z = rnorm(200,0, 200),
    cat = "cat"
  )
dataframe

ggplot(data = dataframe) +
  geom_jitter(aes(x=z, y=x, color = -y), show.legend = FALSE) +
  geom_segment(aes(x=z, y=x, xend = z, yend=y, color = -y), show.legend = FALSE)+
  scale_color_gradientn(colors =get_brewer_pal("Blues", n = 20, contrast = c(0.14, 1))) +
  theme_void() +
  theme(plot.background = element_rect(color = "black", fill = "black")) -> shower


library(gganimate)

shower +
  transition_reveal(along = -x+y) + ease_aes("circular-in") +
  shadow_wake(wake_length = 0.05, alpha = 0.3)-> anim

animate(anim, nframes = 100)



