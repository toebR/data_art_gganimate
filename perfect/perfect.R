library(tidyverse)
library(tmaptools)
library(viridisLite)
library(ambient)

palette_explorer()


dir = "C:\\Users\\tobia\\OneDrive\\Desktop\\generativeArt\\generativeArt"
setwd(dir)

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
try = GenArt_ellipse(n = 100, from = 1, by = 1, rand1 = 2000, rand2 = 0.3, rand3 = 256)
#visual tranformation of the dataframe
try
ggplot(try)+
  geom_line(aes(x=z, y= x, color = z), alpha = .8, size = .3) +
  geom_curve(aes(x =z, y = x, xend = x, yend= x, color = z))+
  geom_point(aes(x = z, y = x, color = z), show.legend = FALSE) +
  scale_color_gradientn(colours = get_brewer_pal("RdPu", n = 20, contrast = c(0.14, 1))) +
  theme_void() +
  xlim(c(-1.5,1.5))+
  ylim(c(-1.5, 1.5))+
  coord_flip() +
  theme(plot.background = element_rect(fill = "black"),
        legend.position = "none") -> poly
poly



ggsave(poly, filename = "perfect_phone.png", width = 14, height = 28, units = "cm", dpi =500, type = "cairo")
ggsave(poly, filename = "perfect_desktop.png", width = 140, height = 75, units = "cm", dpi =500, type = "cairo",
       limitsize = FALSE)
ggsave(poly, filename = "perfect_card.png", width = 12, height = 12, units = "cm", dpi = 500)
ggsave(poly, filename = "perfect_posterA3.png", width = 20, height = 20, units = "cm", dpi = 500)

#vibalicious
curfect vibes
