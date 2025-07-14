#data animation by Tobias Stalder, July 2015


#libs
library(gganimate)
library(tidyverse)
library(dplyr)

#data
bl_funding <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-15/bl_funding.csv')

#mutate dataset
df <- bl_funding %>%
    rename(x1 = nominal_gbp_millions,
    x2 = gia_gbp_millions,
    y1 = total_y2000_gbp_millions,
    y2 = gia_y2000_gbp_millions,
    z1 = voluntary_y2000_gbp_millions,
    z2 = services_y2000_gbp_millions
) %>%
    select(year,x1, x2, y1, y2, z1, z2) %>%
    mutate()


#plot
ggplot(df, aes(color = (x1+x2)/(y1+y2)))+
        geom_segment(aes(x = x1, xend= x2, y= y1, yend=y2))+
    geom_segment(aes(x = y1, xend= y2, y= z1, yend=x1))+
    geom_segment(aes(x = z1, xend= y1, y= x2, yend=z2))+
    geom_segment(aes(x = y2, xend= x2, y= x1, yend=z2))+
    coord_polar() +
    theme_void()+
    theme(plot.background = element_rect(fill = "black"),
        panel.background = element_rect(fill = "black"),
        legend.position = "none") +
    scale_color_gradientn(colours = paletteer::paletteer_c("grDevices::Purple-Yellow", 30)) -> p
p

#animate
p + transition_reveal(along = year) +
  shadow_wake(wake_length = 0.5, alpha = 0.3)+
  ease_aes("sine-in-out")-> anim

animate(anim, nframes = 50, width = 6, height = 6, units = "in", fps = 15, duration = 10, res = 150) -> anim_fin
anim_save(anim_fin, 
          path = r"(path)",
          filename = "bib.gif")


