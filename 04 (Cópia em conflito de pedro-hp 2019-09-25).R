library(ggplot2)

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

p3 <- p2 + scale_x_continuous(breaks = seq(0, 4, by = 0.3)) + scale_y_continuous(breaks = seq(0, 1, by = 0.1))

p4 <- p3 + geom_hline(yintercept = 1, lty = 2, lwd = 1.1, color = "gray40", alpha = 0.6)

p5 <- p4 + stat_function(args = list(shape = 2, scale = 1.5), fun = pweibull, lwd = 1.1) + 
      geom_line(color = "blue", lwd = 1.1) + xlab(label = "x") + ylab(label = "Probabilidade")

theme_pedro <- theme(plot.title = element_text(face = "bold"),
                     axis.text = element_text(face = "bold"))

p5 + theme_pedro
      