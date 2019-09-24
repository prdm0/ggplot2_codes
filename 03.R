library(ggplot2)
library(showtext)
library(cowplot)

font_add_google("Kalam", "kalam")

showtext_auto()


set.seed(0L)
dados <- rweibull(200, shape = 2, scale = 1.5)

p1 <- ggplot(data.frame(x = dados), aes(x = x, y = seq(0, 1, length.out = length(dados)))) +
             scale_x_continuous(breaks = seq(0, 4, by = 0.2))

p2 <- p1 + scale_y_continuous(breaks = seq(0, 1, by = 0.05)) + ylab(label = "Probabilidade")

p3 <- p2 + ggtitle(label = "Código 3", subtitle = "Estudando ggplot2")

p4 <- p3 + geom_histogram(data = data.frame(x = dados), aes(x = x, y = ..density..), bins = 15, fill = "#808080",
                          col = "black") 

p5 <- p4 +  theme(plot.background = element_rect(fill = "white"),
                  panel.background = element_rect(fill = "white"),
                  axis.line = element_line(colour = "black"),
                  axis.title.x = element_text(family = "kalam", face = "bold"),
                  axis.title.y = element_text(family = "kalam", face = "bold"),
                  plot.title = element_text(family = "kalam", face = "bold", size = 20),
                  plot.subtitle = element_text(family = "kalam"),
                  axis.text = element_text(face = "bold"))

p6 <- p5 + background_grid()

p7 <- p6 + stat_function(fun = dweibull, args = list(shape = 2, scale = 1.5), color = "red",
                         mapping = aes(x = seq(0, 3.2, length.out = 200L),
                                       y = seq(0, 1, length.out = 200L)),
                         lwd = 1.3)


plot_grid(p4, p5, p6, p7, labels = LETTERS[1:4])


ggsave(filename = "histogramas.pdf", width = 10, height = 10)

