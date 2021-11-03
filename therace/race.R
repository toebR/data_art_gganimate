library(tidyverse)
library(tmaptools)
library(viridisLite)
library(ambient)
library(ggforce)
library(ggalt)
library(gganimate)
library(ggbump)
library(here)



dataframe = data.frame(t = seq(1, 1000, 1)) %>%
  mutate(
    x = seq(0,999,1),
    y = rnorm(1000,25, 2),
    z = rnorm(1000,25, 2),
    r = rnorm(1000,25, 2),
    cat = "cat"
  )
dataframe

smooth_vals = predict(loess(y~x,dataframe))
smooth_valsZ = predict(loess(z~x,dataframe))
smooth_valsR = predict(loess(r~x,dataframe))
dataframe$smooth_valsY <- smooth_vals
dataframe$smooth_valsZ <- smooth_valsZ
dataframe$smooth_valsR <- smooth_valsR



ggplot(dataframe)+
  geom_hline(yintercept = 25, color = "gray30", linetype = "solid", size = 30) +
  geom_hline(yintercept = 25, color = "white", linetype = "dashed", size = 1.2) +
  geom_hline(yintercept = 25.1,  color = "white", size = 1.2) +
  geom_hline(yintercept = 24.9, color = "white", size = 1.2) +
  geom_line(aes(x = x,y = smooth_valsY), color = "#ce5a57", alpha = 0.25, size = 5) +
  geom_line(aes(x = x,y = smooth_valsY), color = "#ce5a57", alpha = 0.4, size = 1.5) +
  geom_line(aes(x = x,y = smooth_valsY), color = "#ce5a57", size = 0.5) +
  geom_line(aes(x = x,y = smooth_valsZ), color = "#78a5a3", alpha = 0.25, size = 5) +
  geom_line(aes(x = x,y = smooth_valsZ), color = "#78a5a3", alpha = 0.4, size = 1.5) +
  geom_line(aes(x = x,y = smooth_valsZ), color = "#78a5a3", size = 0.5) +
  geom_line(aes(x = x,y = smooth_valsR), color = "#e1b16a", alpha = 0.25, size = 5) +
  geom_line(aes(x = x,y = smooth_valsR), color = "#e1b16a", alpha = 0.4, size = 1.5) +
  geom_line(aes(x = x,y = smooth_valsR), color = "#e1b16a", size = 0.5) +
  geom_point(aes(x = x,y = smooth_valsZ), color = "#78a5a3", size = 3) +
  geom_point(aes(x = x,y = smooth_valsR), color = "#e1b16a", size = 3) +
  geom_point(aes(x = x,y = smooth_valsY), color = "#ce5a57", size = 3) +
  scale_x_continuous(breaks = c(50, 100, 250, 500, 1000))+

  ggtitle("The Race")+
  labs(subtitle = "All it takes are three idiots",
       caption = "Test-Animation by Tobias Stalder\nTwitter: @toeb18")+
  xlab("Meters")+
  theme(plot.background = element_rect(color ="gray6", fill = "gray6"),
        panel.background =  element_rect(color ="gray6", fill = "gray6"),
        plot.title = element_text(color = "white", hjust = 0.5),
        plot.subtitle = element_text(color = "white", hjust = 0.5),
        plot.caption = element_text(color = "grey"),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.major.x = element_line(color = "darkgrey", size = 0.1),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(color = "gray"))-> p1

p1


#Animation
anim <- p1 + transition_reveal(x) + view_step(nsteps = 12, step_length = 0.5, fixed_x = FALSE)
animate(anim, height = 400, width =800, nframes = 200)
anim_save(filename = paste0(here(), "/therace.gif"))


