library(ggplot2)


limitRange <- function(fun, min, max) {
  function(x) {
    y <- fun(x)
    y[x < min  | x > max] <- NA
    return(y)
  }
}

p1 <- ggplot(mapping = aes(seq(-3.5, 3.5, length.out = 500), y = seq(0, 0.4, length.out = 500))) +
             ggtitle(label = "Normal Distribution") + 
             xlab("x") + ylab("Probability Density") + scale_y_continuous(breaks = seq(0, 0.4, by = 0.02)) +
             scale_x_continuous(breaks = seq(-3.5, 3.5, by = 0.5))

p2 <- p1 + stat_function(fun = dnorm, args = list(mean = 0, sd = 1)) + 
  stat_function(fun = limitRange(dnorm, -Inf, -2), geom = "area", mapping =  aes(fill = "rejeicao1")) +
  stat_function(fun = limitRange(dnorm, 2, Inf), geom = "area", mapping =  aes(fill = "rejeicao2"))

newx <- seq(-1.67, 1.67, length.out = 500)

p3 <- p2 + geom_ribbon(mapping = aes(x = newx, ymin = 0.1, 
                 ymax = dnorm(newx), fill = "areaqualquer")) + 
      stat_function(fun = dnorm, args = list(mean = 0, sd = 1), mapping = aes(color = "Normal"))
    
p4 <- p3 + scale_colour_manual(breaks = "Normal", values = "black", name = "Density")      

p4 + scale_fill_manual(breaks = c("Normal", "rejeicao1", "rejeicao2", "areaqualquer"),
                       values = c(rgb(1, 0, 0, 0.2), "gray", "gray", "red10"), name = "Areas")