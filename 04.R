library(ggplot2)
library(showtext)
library(cowplot)


showtext_auto()
font_add_google("Gloria Hallelujah", "gloria")

empirical <- function(x, ...){
  
  domain <- seq(from = floor(min(x)), to = ceiling(max(x)) + 1L, length.out = 1e3L)
  
  test <- function(i) sum(x <= domain[i]) / length(x)
  
  result <- purrr::map_dbl(.x = 1L:length(domain), .f = test)
  
  list(x = domain, y = result)
}


set.seed(0L)
dados <- rweibull(20L, shape = 2, scale = 1.5)

result <- empirical(dados)

x <- result$x
y <- result$y
  
p1 <- ggplot(data = data.frame(x = x, y = y), aes(x = x, y = y))
  
p2 <- p1  + ggtitle(label = "Função de Distribuição Empírica", subtitle = "Gráfico 04")

p3 <- p2 + scale_x_continuous(breaks = seq(0, 4, by = 0.3)) + scale_y_continuous(breaks = seq(0, 1, by = 0.05))

p4 <- p3 + geom_hline(yintercept = 1, lty = 2, lwd = 1.1, color = "gray40", alpha = 0.6)

p5 <- p4 + stat_function(args = list(shape = 2, scale = 1.5), fun = pweibull, lwd = 1.1, show.legend = TRUE, 
                         aes(color = "Teórica")) + 
      geom_line(lwd = 1.1, aes(colour = "Empírica")) + 
      xlab(label = "x") + ylab(label = "Probabilidade")

p6 <- p5 + scale_colour_manual(breaks = c("Teórica", "Empírica"),
                               values = c("black", "blue"), name = "Curvas")

theme_line <- theme(plot.title = element_text(face = "bold", family = "gloria"),
                    plot.subtitle = element_text(family = "gloria"),
                    axis.title = element_text(face = "bold", family = "gloria"),
                    legend.title = element_text(face = "bold"),
                    legend.spacing.y = unit(2, "mm"),
                    legend.spacing.x = unit(5, "mm"),
                    legend.margin = margin(r = 0.6, l = 0.2, b = 0.2, unit = 'cm'),
                    legend.background = element_rect(fill = "gray95", color = "black"),
                    legend.text = element_text(family = "gloria"))

p7 <- p6 + theme_line
  
plot_grid(p1, p5, p6, p7, labels = c("A", "B", "C", "D"))

ggsave(filename = "empirical.pdf", width = 10, height = 10)