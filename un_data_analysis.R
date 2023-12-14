library(tidyverse)

gapminder_data <- read_csv("figures/gapminder_data.csv")

summarize(gapminder_data, averageLifeExp= mean(lifeExp))

gapminder_data %>% summarize(averageLifeExp= mean(lifeExp))

gapminder_data %>%
    summarize(averageLifeExp= mean(lifeExp))

# %>% = shift, command, m

gapminder_data_summarized <- gapminder_data %>% summarize(averageLifeExp = mean(lifeExp))

#danger! put itself into itself and lose data
gapminder_data <- gapminder_data %>%  summarize(averageLifeExp = mean(lifeExp))

gapminder_data %>% 
  summarize(recent_year = max(year))

gapminder_data %>% 
  filter(year == 2007) %>% 
  summarize(average = mean(lifeExp))

# What is the average GDP per capita for the first year in the dataset?

gapminder_data %>% 
  summarize(first_year = min(year))

gapminder_data %>% 
  filter(year == 1952) %>% 
  summarize(average = mean(gdpPercap))

#another quicker way 

gapminder_data %>% 
  filter(year == min(year)) %>% 
  summarize(average = mean(gdpPercap))

#group_by command
gapminder_data %>% 
  group_by(year) %>% 
  summarize(average = mean(lifeExp))

#life expectancy by continent

gapminder_data %>% 
  group_by(continent) %>% 
  summarize(average = mean(lifeExp))

gapminder_data %>% 
  group_by(continent) %>% 
  summarize(average = mean(lifeExp), min = min(lifeExp))

# mutate()

gapminder_data %>% 
  mutate(gdp = pop * gdpPercap)

gapminder_data %>% 
  mutate(gdp = pop * gdpPercap, popInMillions = pop/1000000)

#select ()

gapminder_data %>% 
  select(pop, year)

#select to remove specific columns

gapminder_data %>% 
  select(-continent)

# get a dataframe with only the columns country, continent, year, life expectancy

gapminder_data %>% 
  select(-pop,-gdpPercap)

# Helper functions within 'select()'

gapminder_data %>% 
  select(year, starts_with('c'))

gapminder_data %>% 
  select(ends_with("p"))

?select

gapminder_data %>% 
  select(year, starts_with('con'))


#How to change the dimensions of the dataset of those that are super long or wide

gapminder_data %>% 
  select(country, continent, year, lifeExp) %>% 
  pivot_wider(names_from = year, values_from = lifeExp)

#new dataset

getwd()
gapminder_data_2007 <- read_csv("data/gapminder_data.csv") %>% 
  filter(year == 2007 & continent == "Americas") %>% 
  select(-year, -continent)

read_csv("data/co2-un-data.csv")

temp <- read_csv("data/co2-un-data.csv")

read_csv('data/co2-un-data.csv', skip = 1)

co2_emissions_dirty <- read_csv("data/co2-un-data.csv", skip = 2, 
                                col_names = c("region", "country", 
                                              "year", "series", "value",
                                              "footnotes", "source"))
co2_emissions_dirty

read_csv("data/co2-un-data.csv", skip = 1) %>% 
  rename(country = ...2)

co2_emissions_dirty %>% 
  select(country, year, series, value)

co2_emissions_dirty %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = 
                           "total_emissions", 
                         "Emissions per capita (metric tons of carbon dioxide)" =
                           "per_capita_emissions"))

co2_emissions_dirty %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = 
                           "total_emissions", 
                         "Emissions per capita (metric tons of carbon dioxide)" =
                           "per_capita_emissions")) %>% 
  pivot_wider(names_from = series, values_from = value)


co2_emissions_dirty %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = 
                           "total_emissions", 
                         "Emissions per capita (metric tons of carbon dioxide)" =
                           "per_capita_emissions")) %>% 
  pivot_wider(names_from = series, values_from = value) %>% 
  count(year)

#Filter out data for only 2005 and drop year column

co2_emissions_dirty %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = 
                           "total_emissions", 
                         "Emissions per capita (metric tons of carbon dioxide)" =
                           "per_capita_emissions")) %>% 
  pivot_wider(names_from = series, values_from = value) %>% 
  filter(year == 2005,) %>% 
  select(-year)

#Created actual dataset for cleaned c02_emissions

co2_emissions <-co2_emissions_dirty %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = 
                           "total_emissions", 
                         "Emissions per capita (metric tons of carbon dioxide)" =
                           "per_capita_emissions")) %>% 
  pivot_wider(names_from = series, values_from = value) %>% 
  filter(year == 2005,) %>% 
  select(-year)

co2_emissions

# merging dataframes of gdpPercap and the co2_emissions data - use common column 

inner_join(gapminder_data, co2_emissions)

inner_join(gapminder_data, co2_emissions, by = "country")

gapminder_co2 <- inner_join(gapminder_data_2007, co2_emissions, by = "country")

ggplot(gapminder_co2, aes(x = gdpPercap, y = per_capita_emissions))+
  geom_point()+
  labs(x = "GDP (per capita)", y = "CO2 emitted (per capita)",
       title = "Association between a nation's GDP and CO2 production")

#Some countries may have dropped out if they are labeled differently between the datasets

