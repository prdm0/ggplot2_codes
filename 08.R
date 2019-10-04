library(ggplot2)

fdp_chisq_inf <- function(par, x) {
  k <- par[1]
  c <- par[2]
  dchisq(x = x, df = k) * (1 - (1 - pchisq(q = x, df = k)) ^ c + c * pchisq(q = x, df = k) *
                             (1 - pchisq(q = x, df = k)) ^ (c - 1))
}

p1 <- ggplot(mapping = aes(x = c(0.1, 5), y = c(0, 2))) +
  scale_y_continuous(breaks = seq(0.0, 1, by = 0.05)) +
  scale_x_continuous(breaks = seq(0.0, 5, by = 0.5))


p2 <- p1 +   stat_function(
  fun = dchisq,
  args = list(df = 2),
  mapping = aes(color = "Qui-Quadrado"),
  n = 1e3L
) +
stat_function(
  fun = fdp_chisq_inf, args = list(par = c(2, 40)),
  mapping = aes(color = "Qui-Quadrado inf"),
  n = 1e3L
)

p3 <- p2 + ggtitle(
  label = "Testando Quantis", subtitle = "Chisq x Chisq Inf"
) + ylab("Densidade") + xlab("x")

p4 <- p3 + scale_color_manual(
  values = c("black", "tomato2"),
  breaks = c("Qui-Quadrado", "Qui-Quadrado inf"),
  name = "Densidades"
)

p5 <- p4 + theme(legend.position = "bottom")

p6 <- p5 + guides(color = guide_legend(title.position = "top", title.hjust = 0.5))

p6 + theme(plot.title = element_text(face = "bold"),

