#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
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
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
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
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: political-lang-in-econ
#| echo: false
#| fig-cap: Computed based on @jelveh_political_2023
tr_df <- read_csv("assets/political_lang_estimates.csv")
my_dexp <- function(x) 0.322 + 0.633 * exp(-0.633 * (x+1))
ggplot(tr_df, aes(x=ideology, y=tr_est)) +
  geom_point(size = g_pointsize) +
  #geom_line(linewidth = g_linewidth) +
  stat_function(fun=my_dexp, linewidth = g_linewidth, linetype = "dashed") +
  labs(
    title = "Ideology vs. Optimal Tax Rate Estimates",
    x = "Ideology Score (Campaign Contributions)",
    y = "Published Estimate"
  ) +
  dsan_theme("half") +
  scale_y_continuous(labels = scales::percent) +
  expand_limits(x=c(-1,1))
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
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
# So we have the censored Normal pdf/cdf
library(crch)
gen_test_scores <- function(min_pts, max_pts) {
  score_vals_unif <- runif(num_students, min_pts, max_pts)
  unif_mean <- mean(score_vals_unif)
  unif_sd <- sd(score_vals_unif)
  # Resample, this time censored normal dist
  score_vals <- round(rcnorm(num_students, mean=unif_mean, sd=unif_sd, left=min_pts, right=max_pts), 2)
  return(score_vals)
}
# Test 1
t1_min <- 0
t1_max <- 268.3
t1_score_vals <- gen_test_scores(t1_min, t1_max)
t1_mean <- mean(t1_score_vals)
t1_sd <- sd(t1_score_vals)
get_t1_pctile <- function(s) round(100 * ecdf(t1_score_vals)(s), 1)
# Test 2
t2_min <- -1
t2_max <- 1.2
t2_score_vals <- gen_test_scores(t2_min, t2_max)
t2_mean <- mean(t2_score_vals)
t2_sd <- sd(t2_score_vals)
get_t2_pctile <- function(s) round(100 * ecdf(t2_score_vals)(s), 1)
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
whoami <- 29
score_df <- score_df |>
  mutate(is_me = as.numeric(id == whoami))
library(ggplot2)
t1_line_data <- tibble(
  x = score_df$t1_pctile,
  y = 0,
  me = score_df$is_me
)
ggplot(t1_line_data, aes(x, y, col=factor(me), shape=factor(me))) +
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
    axis.ticks.y=element_blank(),
    panel.spacing = unit(0, "mm"),
    plot.margin = margin(-35, 0, 0, 0, "pt"),
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
#
#
#| label: scaled-score-numberline
#| fig-height: 2.5
library(scales)
score_df <- score_df |>
  mutate(
    t1_rescaled = rescale(
      t1_score,
      from = c(t1_min, t1_max),
      to = c(0, 100)
    ),
    t2_rescaled = rescale(
      t2_score,
      from = c(t2_min, t2_max),
      to = c(0, 100)
    )
  )
# Place "me" last so that it gets plotted last
t1_rescaled_line_data <- tibble(
  x = score_df$t1_rescaled,
  y = 0,
  me = score_df$is_me
) |> arrange(me)
ggplot(t1_rescaled_line_data, aes(x,y,col=factor(me), shape=factor(me))) +
  geom_point(size=g_pointsize) +
  scale_x_continuous(breaks=seq(from=0, to=100, by=10)) +
  dsan_theme("half") +
  expand_limits(x=c(0, 100)) +
  theme(
    legend.position="none", 
    #rect = element_blank(),
    #panel.grid = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.line.y = element_blank(),
    axis.ticks.y=element_blank(),
    #panel.spacing = unit(0, "mm"),
    #plot.margin = margin(-40, 0, 0, 0, "pt"),
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
#
#
#
#
#
#| label: z-score-numberline
#| fig-height: 2.5
#| fig-width: 10
t1_z_score_line_data <- tibble(
  x = score_df$t1_z_score,
  y = 0,
  me = score_df$is_me
) |> arrange(me)
ggplot(t1_z_score_line_data, aes(x, y, col=factor(me), shape=factor(me))) +
  geom_point(aes(size=g_pointsize)) +
  scale_x_continuous(breaks=c(-2,-1,0,1,2)) +
  dsan_theme("half") +
  theme(
    legend.position="none", 
    #rect = element_blank(),
    #panel.grid = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.line.y = element_blank(),
    axis.ticks.y=element_blank(),
    plot.margin = margin(-20,0,0,0,"pt")
  ) +
  expand_limits(x=c(-2,2)) +
  labs(
    x = "Test 1 Z-Score"
  ) +
  coord_fixed(ratio = 3)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: boxplot-outliers
#| fig-height: 3
library(ggplot2)
library(tibble)
library(dplyr)
# Generate normal data
dist_df <- tibble(Score=rnorm(95), Distribution="N(0,1)")
# Add outliers
outlier_dist_sd <- 6
outlier_df <- tibble(Score=rnorm(5, 0, outlier_dist_sd), Distribution=paste0("N(0,",outlier_dist_sd,")"))
data_df <- bind_rows(dist_df, outlier_df)
# Compute iqr and outlier range
q1 <- quantile(data_df$Score, 0.25)
q3 <- quantile(data_df$Score, 0.75)
iqr <- q3 - q1
iqr_cutoff_lower <- q1 - 1.5 * iqr
iqr_cutoff_higher <- q3 + 1.5 * iqr
is_outlier <- function(x) (x < iqr_cutoff_lower) || (x > iqr_cutoff_higher)
data_df['Outlier'] <- sapply(data_df$Score, is_outlier)
#data_df
ggplot(data_df, aes(x=Score, y=factor(0))) + 
  geom_boxplot(outlier.color = NULL, linewidth = g_linewidth, outlier.size = g_pointsize / 1.5) +
  geom_jitter(data=data_df, aes(col = Distribution, shape=Outlier), size = g_pointsize / 1.5, height=0.15, alpha = 0.666) +
  geom_vline(xintercept = iqr_cutoff_lower, linetype = "dashed") +
  geom_vline(xintercept = iqr_cutoff_higher, linetype = "dashed") +
  #coord_flip() +
  dsan_theme("half") +
  theme(
    axis.title.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.text.y = element_blank()
  ) +
  scale_x_continuous(breaks=seq(from=-3, to=3, by=1)) +
  scale_shape_manual(values=c(16, 4))
#
#
#
#
#
#
#
#
mean_score <- mean(data_df$Score)
sd_score <- sd(data_df$Score)
lower_cutoff <- mean_score - 3 * sd_score
upper_cutoff <- mean_score + 3 * sd_score
ggplot(data_df, aes(x=Score)) + 
  geom_density(linewidth = g_linewidth) +
  #geom_boxplot(outlier.color = NULL, linewidth = g_linewidth, outlier.size = g_pointsize / 1.5) +
  #geom_jitter(data=data_df, aes(y = factor(0), col = dist), size = g_pointsize / 1.5, height=0.25) +
  #coord_flip() +
  dsan_theme("half") +
  theme(
    axis.title.y = element_blank(),
    #axis.ticks.y = element_blank(),
    #axis.text.y = element_blank()
  ) +
  #geom_boxplot() +
  geom_vline(xintercept = mean_score, linetype = "dashed") +
  geom_vline(xintercept = lower_cutoff, linetype = "dashed") +
  geom_vline(xintercept = upper_cutoff, linetype = "dashed") +
  geom_jitter(data=data_df, aes(x = Score, y = 0, col = Distribution, shape = Outlier),
    size = g_pointsize / 1.5, height=0.025, alpha=0.5) +
  scale_x_continuous(breaks=seq(from=-3, to=3, by=1)) +
  scale_shape_manual(values=c(16, 4))
#
#
#
#
#
#
#
#
#
#
#
