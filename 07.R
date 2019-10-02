library(ggplot2)

set.seed(0L)

dados_1 <- rweibull(100L, 1.2 , 1.5)
dados_2 <- rweibull(100L, 0.5, 1.8)
x <- seq(0, 5.5, length.out = 100L)
y <- seq(0, 0.6, length.out = 100L)

ggplot(mapping = aes(x = x, y = y)) + scale_x_continuous(name = "x", breaks = seq(0, 5.5, by = 0.5)) +
  scale_y_continuous(name = "Densidade", breaks = seq(0, 0.6, by = 0.05)) +
  stat_function(
    fun = dweibull,
    args = list(shape = 1.2, scale = 1.5),
    mapping = aes(x = x, y = y, color = "curva1"),
    n = 1e3L
  ) +
  stat_function(
    fun = dweibull,
    args = list(shape = 2.5, scale = 3.8),
    mapping = aes(x = x, y = y,
                  color = "curva2"),
    n = 1e3L
  ) +
  ggtitle(label = "Curvas densidade de probabilidade", subtitle = "Gráfico 07") +
  scale_color_manual(
    values = c("black", "red"),
    breaks = c("curva1", "curva2"),
    name = "Funções Densidade",
    labels = c(expression(paste("Weibull(", alpha, ", ", beta, ")")),
               expression(paste("Weibull(", alpha, ", ", beta, ")")))
  ) + 
  theme(
    plot.title = element_text(face = "bold"),
    legend.title = element_text(face = "bold"),
    axis.title = element_text(face = "bold")
  )
