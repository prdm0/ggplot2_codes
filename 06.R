library(ggplot2)

y <- iris %>% group_by(Species) %>% summarise(n = n()) %>% 
     extract(2) 

p1 <- ggplot(mapping = aes(x = levels(iris$Species), y = unlist(y)))

p2 <- p1 + ggtitle(label = "Gráfico de Barras", subtitle = "Dados iris") +
      ylab(label = "Number") + xlab("Species")

p3 <- p2 + geom_bar(stat = "identity") + geom_text(aes(label=unlist(y)), vjust=3.5, color = "white", size=3.5)

p3 + theme_classic()
