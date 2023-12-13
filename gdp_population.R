#Script to analyze relationship between GDP and Life Expectancy
library(tidyverse)
gapminder_1997 <- read_csv("gapminder_1997.csv")
View(gapminder_1997)

name <- "Ben"
name

age <- 26
age

name <- "Harry Potter"
name

name_character <- "Harry Potter"
name_character

read_csv("gapminder_1997.csv")

test <- read.csv("gapminder_1997")

Sys.Date() #outputs the current date, used for knowing when I last ran

getwd()#output current directory

sum(5,6)#adds numbers

round(3.1415, digits = 2)
round(3.1415, 2)

read_csv(file = 'gapminder_1997.csv')

gapminder_1997 <- read_csv("gapminder_1997.csv")

ggplot(data=gapminder_1997) + 
  aes(x=gdpPercap)+
  labs(x="GDP Per Capita")+
  aes(y=lifeExp)+
  labs(y="Life Expectancy")+
  geom_point()+
  labs(title = "Do People in Wealthy Countries Live Longer?")+
  aes(color=continent)+
  scale_color_brewer(palette ="Set1")+
  aes(size=pop/1000000)+
  labs(size="Population (millions)")+
  aes(shape=continent)

ggplot(data = gapminder_1997)+
  aes(x= gdpPercap, y= lifeExp, color= continent, size= pop/1000000, shape= continent)+
  geom_point()+
  scale_color_brewer(palette= "Set1")+
  labs(x= "GDP Per Capita",y="Life Expectancy",
       title = "Do People in Wealthy Countries Live Longer?",
       size= "Population (millions)")

gapminder_data <- read_csv("gapminder_data.csv")  
dim(gapminder_data)
head(gapminder_data)

#x=year, y= lifeExp, color = continent

#aes(x= gdpPercap, y= lifeExp, color= continent, size= pop/1000000, shape= continent)+
#geom_point()+
 # scale_color_brewer(palette= "Set1")+
  #labs(x= "GDP Per Capita",y="Life Expectancy",
   #    title = "Do People in Wealthy Countries Live Longer?",
    #   size= "Population (millions)")
ggplot(gapminder_data)+
  aes(x= year, y= lifeExp, color= continent)+
  geom_point()+
  labs(x= "Year", y= "Life Expectancy")

ggsave("figures/gdpPerCap_lifeExp.png")

    