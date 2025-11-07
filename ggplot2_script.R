## Instalacion de paquetes
#install.packages("tidyverse")
#install.packages("ggplot2")
#install.packages("gapminder")

## Cargamos los paquetes
library(tidyverse)
library(gapminder)

## Guardamos gapminder en un df llamado df.
df <- gapminder

## Empezamos el primer plot. Que notas?
ggplot(data= gapminder) +
  aes(x = gdpPercap,
      y = lifeExp)

## Tenemos los datos, tenemos que anadir una capa de geom
## en este caso geom_point
ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp) +
  geom_point()

## La grafica es un poco confusa, vamos a anadir un aesthetic: 
## colorea los puntos con base en el continente.
ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp,
      color = continent) + 
  geom_point()

## Todos los puntos estan del lado izquierdo. Por que?
## Una forma de solucionarlo es cambiando la escala
ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp,
      color = continent) +
  geom_point() +
  scale_x_log10()

## La grafica aun es un poco confusa, que tal si creamos una grafica que 
## separa las graficas por continente?
## cual crees que es la funcion de guides?
ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp,
      color = continent) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~ continent) + 
  guides(color = FALSE)     

## Tal vez podemos mejorar la grafica haciendo los puntos
## mas pequenos
ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp,
      color = continent) +
  geom_point(size = 0.25) + #<<
  scale_x_log10() +
  facet_wrap(~ continent) +
  guides(color = FALSE) 

## Que tal si anadimos una geometria extra y conectamos
## los puntos con lineas?
ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp,
      color = continent) +
  geom_line() + #<<
  geom_point(size = 0.25) +
  scale_x_log10() +
  facet_wrap(~ continent) +
  guides(color = FALSE)

## Los puntos y lineas estan conectados, pero los puntos son de
## diferentes paises. Vamos a crear lineas basados en los paises
## de cada continente
ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp,
      color = continent) +
  geom_line(
    aes(group = country) #<<
  ) +
  geom_point(size = 0.25,) +
  scale_x_log10() +
  facet_wrap(~ continent) +
  guides(color = FALSE)



## Cambiemos lo que vamos a graficar. Ahora en x = year, y y=gdpPercap
ggplot(gapminder) +
  aes(x = year, #<<
      y = gdpPercap, #<<
      color = continent) +
  geom_line(
    aes(group = country)
  ) +
  geom_point(size = 0.25) +
  facet_wrap(~ continent) +
  guides(color = FALSE)

## Los ejes de las graficas muestran mucha informacion
## que tal si solo queremos ver numeros de 1950 a 2000 con saltos de 25
## la escala tal vez necesita ser cambiada
ggplot(gapminder) +
  aes(x = year,
      y = gdpPercap,
      color = continent) +
  geom_line(
    aes(group = country)
  ) +
  geom_point(size = 0.25) +
  scale_y_log10() +
  scale_x_continuous(            #<<
    breaks = #<<
      seq(1950, 2000, 25) #<<
  ) +                            #<<
  facet_wrap(~ continent) +
  guides(color = FALSE)

## Vamos a hacer el plot un poco mas bonito
ggplot(gapminder) +
  aes(x = year,
      y = gdpPercap,
      color = continent) +
  geom_line(
    aes(group = country)
  ) +
  geom_point(size = 0.25) +
  scale_y_log10() +
  scale_x_continuous(            #<<
    breaks = #<<
      seq(1950, 2000, 25) #<<
  ) +                            #<<
  facet_wrap(~ continent) +
  guides(color = FALSE) +
  theme_bw()

###########################################################################
## Plot 2 
## Vamos a trabajar con datos de America.
## Usamos dplyr para filtrar nuestro dataset

americas <- 
  gapminder %>% 
  filter(
    country %in% c(
      "United States",
      "Canada",
      "Mexico",
      "Ecuador"
    ))


## Comenzamos con un grafico de columnas comparando anio y poblacion
ggplot(americas) +
  aes(
    x = year,
    y = pop
  ) +
  geom_col()

## El grafico anterior, suma todas las entradas por anio
## Pero estamos interesados en separar por pais.
## fill = country
ggplot(americas) +
  aes(
    x = year,
    y = pop,
    fill = country #<<
  ) +
  geom_col()

## Pregunta: cual crees que se la funcion de position = dodge?
## dodge coloca las barras lado a lado
ggplot(americas) +
  aes(
    x = year,
    y = pop,
    fill = country
  ) +
  geom_col(
    position = "dodge" #<<
  )

## Los numeros de los ejes son muy grandes
## vamos a dividir entre un millon el numero de habitantes
ggplot(americas) +
  aes(
    x = year,
    y = pop / 10^6, #<<
    fill = country
  ) +
  geom_col(
    position = "dodge" 
  )

## Otra opcion: que tal si separamos las graficas por pais
## en un grafico por pais?
## usamos facet_wrap 
ggplot(americas) +
  aes(
    x = year,
    y = pop / 10^6,
    fill = country
  ) +
  geom_col(
    position = "dodge" 
  ) +
  facet_wrap(~ country) + 
  guides(fill = FALSE)



## Los graficos se verian mejor si cada grafica tiene su propio valor
## en el eje de las y. Con free_y, lo dejamos variar
ggplot(americas) +
  aes(
    x = year,
    y = pop / 10^6,
    fill = country
  ) +
  geom_col(
    position = "dodge" 
  ) +
  facet_wrap(~ country,
    scales = "free_y") + #<<
  guides(fill = FALSE)

## ----gapminder-americas-7, fig.show="hide"-------------------------------
## lo volvemos mas bonito
ggplot(americas) +
  aes(
    x = year,
    y = lifeExp, #<<
    fill = country
  ) +
  geom_col(
    position = "dodge" 
  ) +
  facet_wrap(~ country,
    scales = "free_y") +
  guides(fill = FALSE) +
  theme_minimal()

## 

## Ahora vamos a analizar la expectativa de vida. Un plot para ver mejor las 
## tendencias seria un geom_line
ggplot(americas) +
  aes(
    x = year,
    y = lifeExp,
    color = country #<<
  ) +
  geom_line() +
  facet_wrap(~ country,
    scales = "free_y") +
  guides(color = FALSE) #<<

## Otra opcion: Una sola grafica. No facet wrap
ggplot(americas) +
  aes(
    x = year,
    y = lifeExp,
    color = country
  ) +
  geom_line()

## Ggplot es muy dinamico, podemos filtrar los datos y conectar
## la grafica, por que no se ve una grafica?
gapminder %>% 
  filter(
    continent == "Americas"
  ) %>% #<<
  ggplot() + #<<
  aes(
    x = year,
    y = lifeExp
  )

## Necesitamos anadir una capa de geom.
## Ahora vamos a trabajar con un boxplot
gapminder %>% 
  filter(
    continent == "Americas"
  ) %>%
  ggplot() +
  aes(
    x = year,
    y = lifeExp
  ) +
  geom_boxplot()

##

## Podemos obtener los boxplots de America por anios
gapminder %>% 
  filter(
    continent == "Americas"
  ) %>%
  mutate( #<<
    year = factor(year) #<<
  ) %>%  #<<
  ggplot() +
  aes(
    x = year,
    y = lifeExp
  ) +
  geom_boxplot()


## Podemos ahora colorear por continente por ano
gapminder %>% 
  mutate(
    year = factor(year)
  ) %>% 
  ggplot() +
  aes(
    x = year,
    y = lifeExp,
    fill = continent #<<
  ) +
  geom_boxplot()

## Podemos voltear el grafico
## con coord_flip
g <- gapminder %>% 
  mutate(
    year = factor(year)
  ) %>% 
  ggplot() +
  aes(
    x = year,
    y = lifeExp,
    fill = continent
  ) +
  geom_boxplot() +
  coord_flip() #<<
g

## Vamos a cambiar el nombre de los ejes
## anadir titulo y caption
g1 <- g +
  theme_minimal() +
  labs(
    x = "Life Expectancy",
    y = "Decade",
    fill = NULL,
    title = "Life Expectancy by Continent and Decade",
    caption = "gapminder.org"
  )

## guardamos
ggsave(filename = "mi_plot.png", plot = g1, width = 10, height = 8, bg = "white")


#### extra
## como animar
library(gganimate)

##
ghra <- gapminder %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop, color = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_x_log10() +
  facet_wrap(~ continent) +
  theme_minimal()
ghra

# Paso 1: Crear el objeto de animación
animation <- ghra +
  transition_states(year, transition_length = 1, state_length = 0) +
  ggtitle("{closest_state}")

# Paso 2: Renderizarlo (opcional si solo vas a guardarlo)
animate(animation)

# Paso 3: Guardar como GIF (usa 'animation', no 'animated_plot')
anim_save("mi_animacion.gif", width = 1000, height = 1000, animation = animation, renderer = gifski_renderer())

## Paso 4: improve quality
animate(
  animation,
  width = 1200,
  height = 900,
  res = 500,          # DPI — 150–200 looks great
  renderer = gifski_renderer()
)

##
anim_save("mi_animacion_hd.gif", animation = last_animation())
