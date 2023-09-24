#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: r-source-globals
source("../_globals.r")
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: tidyverse-select-load-data
library(tidyverse)
table1
#
#
#
#| label: tidyverse-select
#| code-fold: show
table1 |> select(country, year, population)
#
#
#
#
#
#
#
#
#
#
#
#| label: tidyverse-filter-year
#| code-fold: show
table1 |> filter(year == 2000)
#
#
#
#| label: tidyverse-filter-country
#| code-fold: show
table1 |> filter(country == "Afghanistan")
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: tidyverse-filter-select
#| code-fold: show
df <- table1 |>
  select(country, year, population) |>
  filter(year == 2000)
df |> write_csv("assets/pop_2000.csv")
df
#
#
#
#
#
#
#
#| label: load-gdp-data
#| code-fold: show
gdp_df <- read_csv("https://gist.githubusercontent.com/jpowerj/c83e87f61c166dea8ba7e4453f08a404/raw/29b03e6320bc3ffc9f528c2ac497a21f2d801c00/gdp_2000_2010.csv")
gdp_df |> head(5)
#
#
#
#
#
#
#
#
#
#| label: clean-gdp-data
#| code-fold: show
gdp_2000_df <- gdp_df |>
  select(`Country Name`,Year,Value) |>
  filter(Year == "2000") |>
  rename(country=`Country Name`, year=`Year`, gdp=`Value`)
gdp_2000_df |> write_csv("assets/gdp_2000.csv")
gdp_2000_df |> head()
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: r-long-data
table2 |> write_csv("assets/long_data.csv")
table2 |> head()
#
#
#
#
#
#
#
#
#| label: r-wide-data
table1 |> write_csv("assets/wide_data.csv")
table1 |> head()
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: r-display-wide-for-reshape
#| code-fold: show
table1
#
#
#
#
#
#
#| label: r-reshape
#| code-fold: show
long_df <- gather(table1,
  key = "variable",
  value = cases,
  -c(country, year)
)
long_df |> head()
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: r-gen-test-scores
#| code-fold: true
num_students <- 30
student_ids <- seq(from = 1, to = num_students)
# Test 1
t1_min_pts <- 0
t1_max_pts <- 268.3
t1_score_vals <- round(runif(num_students, t1_min_pts, t1_max_pts), 2)
t1_mean <- mean(t1_score_vals)
t1_sd <- sd(t1_score_vals)
get_t1_pctile <- function(s) round(100 * ecdf(t1_score_vals)(s), 1)
# Test 2
t2_min_pts <- -1
t2_max_pts <- 1.2
t2_score_vals <- round(runif(num_students, t2_min_pts, t2_max_pts), 2)
t2_mean <- mean(t2_score_vals)
t2_sd <- sd(t2_score_vals)
get_t2_pctile <- function(s) round(100 * ecdf(t2_score_vals)(s), 2)
score_df <- tibble(
  id=student_ids,
  t1_score=t1_score_vals,
  t2_score=t2_score_vals
)
score_df <- score_df |> arrange(desc(t1_score))
#
#
#
#
#
#
#
#| label: r-test-scores-unnormalized
#| echo: false
score_df |> head()
#
#
#
#
#
#
#
#
#
#
#| label: r-normalize-test-scores
score_df <- score_df |>
  mutate(
    t1_z_score = round((t1_score - t1_mean) / t1_sd, 2),
    t2_z_score = round((t2_score - t2_mean) / t2_sd, 2),
    t1_pctile = get_t1_pctile(t1_score),
    t2_pctile = get_t2_pctile(t2_score)
  ) |>
  relocate(t1_pctile, .after = t1_score) |>
  relocate(t2_pctile, .after = t2_score)
#
#
#
#
#
#
#
#| label: r-normalized-scores
#| echo: false
score_df |> head()
#
#
#
#
#
#
#
#
#
#
#| label: pctile-numberline
#| fig-height: 2.5
# https://community.rstudio.com/t/number-line-in-ggplot/162894/4
# Add a binary indicator to track "me" (student #8)
score_df <- score_df |>
  mutate(is_me = as.numeric(id == 8))
library(ggplot2)
t1_line_data <- tibble(
  x = score_df$t1_pctile,
  y = 0,
  me = score_df$is_me
)
ggplot(t1_line_data, aes(x,y,col=factor(me))) +
  geom_point(aes(size=g_pointsize)) +
  scale_x_continuous(breaks=seq(from=0, to=100, by=10)) +
  scale_color_discrete(c(0,1)) +
  dsan_theme("half") +
  theme(
    legend.position="none", 
    #rect = element_blank(),
    #panel.grid = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.line.y = element_blank(),
    axis.ticks.y=element_blank()
  ) +
  labs(
    x = "Test 1 Percentile"
  ) +
  coord_fixed(ratio = 100)
#
#
#
#
#
#| label: scaled-score-numberline
#| fig-height: 2.5
library(scales)
score_df <- score_df |>
  mutate(
    t1_rescaled = rescale(
      t1_score,
      from = c(t1_min_pts, t1_max_pts),
      to = c(0, 100)
    ),
    t2_rescaled = rescale(
      t2_score,
      from = c(t2_min_pts, t2_max_pts),
      to = c(0, 100)
    )
  )
library(ggplot2)
t1_rescaled_line_data <- tibble(
  x = score_df$t1_rescaled,
  y = 0,
  me = score_df$is_me
)
ggplot(t1_rescaled_line_data, aes(x,y,col=factor(me))) +
  geom_point(aes(size=g_pointsize)) +
  scale_x_continuous(breaks=seq(from=0, to=100, by=10)) +
  dsan_theme("half") +
  theme(
    legend.position="none", 
    #rect = element_blank(),
    #panel.grid = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.line.y = element_blank(),
    axis.ticks.y=element_blank()
  ) +
  labs(
    x = "Test 1 Score (Rescaled to 0-100)"
  ) +
  coord_fixed(ratio = 100)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
