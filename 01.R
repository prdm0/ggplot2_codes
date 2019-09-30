# ggplot(mpg, aes(hwy)) + geom_histogram(fill = "gray", alpha = 2/3) + theme_classic() + 
#   geom_text(aes(25, 0.2, label = "Teste"), angle = 45, family = "Times New Roman", color = "blue") + 
#   geom_hline(yintercept = 30) + geom_vline(xintercept = 30)  + 
#   ggtitle("Título do gráfico construído usando o ggplot2", subtitle = "Um pequeno teste") +
#   theme(plot.title = element_text(hjust = 0.5)) +
#   geom_segment(aes(x = 10, y = 0, xend = 30, yend = 30)) + geom_segment(aes(x = 10, y = 0, xend = 30, yend = 0)) + 
#   geom_point(aes(30, 30), color = "blue", size = 5, pch = 19)

library(ggplot2)

x <- seq(-15, 15, length.out = 200L)
dados <- data.frame(x = x, tipo = factor(rep(c("A", "B"), each = 200)), y = c(dnorm(x, 0, 1), dnorm(x, 2, 2)))


p1 <- ggplot(mapping = aes(x = c(-15, 15), y = c(0, 0.3))) + 
        stat_function(fun = dnorm, n = 1000L, args = list(mean = 0, sd = 2),  aes(color = "Gráfico 1")) +
        stat_function(fun = dnorm, n = 1000L, args = list(mean = 2, sd = 2),  aes(color = "Gráfico 2")) + 
        scale_color_manual(values = c("blue", "red"), name = "Curva Normal: ")
p2 <- p1 + scale_x_continuous(name = "x", breaks = seq(-15, 15, 1)) + 
      scale_y_continuous(name = "y", breaks = seq(0, 1, by = 0.01)) 
 
p3 <- p2 + ggtitle(label = "Curvas Normais", subtitle = "Estudando o ggplot2")

arrow <- arrow(length = unit(0.2, "cm"), type = "open")

p4 <- p3 + theme(legend.title = element_text(face = "bold"),
           plot.title = element_text(face = "bold"),
           legend.position = "bottom",
           panel.background = element_rect(fill = "white"),
           axis.line = element_line(colour = "red", size = 0.4, arrow = arrow),
           axis.ticks.x = element_line(color = "blue", size = 0.6))
set.seed(0)
p5 <- p4 + geom_histogram(data.frame(x = rnorm(100, 0 , 2)), mapping = aes(x = x, y =..density..), alpha = 0.5,
                          colour = "white", size = 0.56, fill = "blue")

p6 <- p5 + geom_histogram(data.frame(x = rnorm(100, 2 , 2)), mapping = aes(x = x, y =..density..), alpha = 0.2,
                          colour = "white", size = 0.5, fill = "red")

p7 <- p6 + geom_segment(mapping = aes(x = -15, y = 0.10, xend = -10, yend = 0.10)) + 
      geom_segment(mapping = aes(x = -15, y = 0.10, xend = -15, yend = 0.16)) + 
      geom_segment(mapping = aes(x = -15, y = 0.16, xend = -10, yend = 0.16)) +
      geom_segment(mapping = aes(x = -10, y = 0.10, xend = -10, yend = 0.16)) 

p8 <- p7 + geom_rect(aes(xmin = -15, xmax = -10, ymin = 0.10, ymax = 0.16), fill = "green")

p8