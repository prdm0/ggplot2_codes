library(ggplot2)

set.seed(0L)
dados <- rweibull(200, shape = 2, scale = 1.5)

p1 <- ggplot(data.frame(x = dados), aes(x = x, y = seq(0, 1, length.out = length(dados)))) +
             scale_x_continuous(breaks = seq(0, 4, by = 0.2))

p2 <- p1 + scale_y_continuous(breaks = seq(0, 1, by = 0.1)) + ylab(label = "Probabilidade")

p3 <- p2 + ggtitle(label = "Código 3", subtitle = "Estudando ggplot2")

p4 <- p3 + geom_histogram(data = data.frame(x = dados), aes(x = x, y = ..density..), bins = 10, fill = "#bdbdbd") 

p5 <- p4 +  theme(
                  axis.text.x=element_text(colour="black", size = 7),
                  axis.text.y=element_text(colour="black", size = 7)) 