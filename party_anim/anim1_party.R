library(tidyverse)
library(tmaptools)
library(viridisLite)
library(ambient)
library(ggforce)
library(ggalt)
library(paletteer)
# paletteer::paletteer_c_()
# 
# palette_explorer()

# dir = "C:\\Users\\tobia\\OneDrive\\Desktop\\ownprojects\\R\\generativeArt"
# setwd(dir)

dataframe = data.frame(t = seq(1, 50, 1)) %>%
  mutate(
    x = runif(50, -20, 30),
    y = runif(50, -200, 200),
    z = rnorm(50,0, 100),
    r = rnorm(50, 0, 500) + sin(z*x),
    cat = "cat"
  )
dataframe



#play SQRT!!
# ggplot(data = dataframe) +
#   geom_path(aes(x=x, y=y, color = y), show.legend = FALSE)+
#   scale_color_gradientn(colors =get_brewer_pal("Reds", n = 20, contrast = c(0.2, 1))) +
#   theme_void() +
#   theme(plot.background = element_rect(color = "black", fill = "black"))  -> SQRT
# SQRT
# 
# ggsave(SQRT, filename = "SQRT_card.png", width = 12, height = 12, units = "cm", dpi = 500)
# ggsave(SQRT, filename = "SQRT_posterA3.png", width = 20, height = 20, units = "cm", dpi = 500)

#sqrt ROUND!!
ggplot(data = dataframe) +

  geom_point(aes(x=-r, y=-z, color = -r), alpha = .8) +
  geom_point(aes(x=-y, y=-r, color = -r), alpha = .8) +
  geom_curve(aes(x=-r, y=-z, xend=-y, yend=-r, color = -r), alpha = .8)+
  geom_curve(aes(x=-y, y=-r, xend=-r, yend=-z, color = -r), alpha = .8)+
  geom_curve(aes(x=r, y=z, xend=y, yend=r, color = r))+
  geom_curve(aes(x=y, y=r, xend=r, yend=z, color = r))+
  geom_point(aes(x=r, y=z, color = r)) +
  geom_point(aes(x=y, y=r, color = r)) +
  scale_color_gradientn(colors = get_brewer_pal("PuOr", n = 9, contrast = c(.1,0.8))) +
  theme_void()+
  theme(plot.background = element_rect(fill = "black"),
        panel.background = element_rect(fill = "black"),
        legend.position = "none") -> test
  test
# ggsave(test, filename = "Desicion_card.png", width = 12, height = 12, units = "cm", dpi = 500)
# ggsave(test, filename = "Desicion_posterA3.png", width = 20, height = 20, units = "cm", dpi = 500)

  library(gganimate)

test +
  transition_reveal(along=z) + enter_grow() +
  shadow_mark(future = TRUE)-> anim

animate(anim, nframes = 220, fps = 30, device = "png", rewind = TRUE,
        width = 6, height = 6, units ="in", res = 400) -> anim_fin
anim_save(animation = anim_fin, path = r"(C:\Users\tobia\Desktop\dataviz\genart\animation)",
          filename = "test2.gif")

warnings()
