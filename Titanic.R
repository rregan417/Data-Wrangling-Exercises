library(ggplot2)

str(Titanic)

ggplot(Titanic, aes(x = Pclass, y=Age, color = Sex)) +
  geom_point(size = 3, alpha = 0.5, position = posn.jd) +
  facet_grid(.~Survived)
