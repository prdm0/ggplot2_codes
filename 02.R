library(ggplot2)
library(showtext)

# Temas par o ggplot2: https://yutannihilation.github.io/allYourFigureAreBelongToUs/
# yay -S ttf-google-fonts-git --noconfirm


font_add_google("Schoolbell", "bell")
font_add_google("Satisfy", "satisfy")
showtext_auto()
#options("device" = "RStudioGD")


p1 <- ggplot(mapping = aes(x = c(-1, 1), y = c(-1, 1)))

p2 <- p1 + xlab("x") + ylab("y") + ggtitle(label = "Código 02", subtitle = "Estudando ggplot2")

p3 <- p2 + geom_hline(yintercept = 0) + xlim(-1, 1) + ylim(-1, 1) + geom_vline(xintercept = 0)

p4 <- p3 + geom_abline(intercept = 0, slope = -1) + geom_abline(intercept = 0, slope = 1)

p5 <- p4 + geom_point(aes(x = 0, y = 0), size = 5, color = "red", fill = "blue", shape = 21, stroke = 2.5)

p6 <- p5 + geom_point(mapping = aes(x = 0, y = 0), size = 20, alpha = 0.5, color = "blue")

p7 <- p6 + geom_rect(xmin = -0.5, xmax = 0.5, ymin = -0.5, ymax = 0.5, alpha = 0.4, fill = "orange",
                     colour = "red", linetype = 1, size = 2)

p8 <- p7 + scale_x_continuous(breaks = seq(-1, 1, by = 0.1)) + scale_y_continuous(breaks = seq(-1, 1, by = 0.1))


df <- data.frame(x = c(-1, -0.9, -0.9), y = c(0.005, 0.005, 0.2))

p9 <- p8 + geom_polygon(data = df, mapping = aes(x = x, y = y), fill = "gray", color = "blue", stroke = 2.5, size = 0.8)

p10 <- p9 + annotate(geom = "text", x = -0.6, y = 0.28, label = "Um texto maior ...",
                     angle = 45, family = "bell", size = 10)

p11 <- p10 + theme(axis.ticks.x = element_line(color = "blue", size = 2))

p11 + theme(plot.title = element_text(family = "satisfy", size = 25),
            plot.subtitle = element_text(family = "satisfy", size = 15))

p11

#ggsave(filename = "figura.pdf", width = 10, height = 10)