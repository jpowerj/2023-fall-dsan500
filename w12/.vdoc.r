#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: sine-wave-tree
library(tidyverse)
library(latex2exp)
expr_pi2 <- TeX("$\\frac{\\pi}{2}$")
expr_pi <- TeX("$\\pi$")
expr_3pi2 <- TeX("$\\frac{3\\pi}{2}$")
expr_2pi <- TeX("$2\\pi$")
x_range <- 2 * pi
x_coords <- seq(0, x_range, by = x_range / 100)
num_x_coords <- length(x_coords)
data_df <- tibble(x = x_coords)
data_df <- data_df |> mutate(
  y_raw = sin(x),
  y_noise = rnorm(num_x_coords, 0, 0.15)
)
data_df <- data_df |> mutate(
  y = y_raw + y_noise
)
#y_coords <- y_raw_coords + y_noise
#y_coords <- y_raw_coords
#data_df <- tibble(x = x, y = y)
reg_tree_plot <- ggplot(data_df, aes(x=x, y=y)) +
  geom_point(size = g_pointsize / 2) +
  dsan_theme("half") +
  labs(
    x = "Feature",
    y = "Label"
  ) +
  # geom_vline(
  #   xintercept = pi,
  #   linewidth = g_linewidth,
  #   linetype = "dashed"
  # ) +
  scale_x_continuous(
    breaks=c(0,pi/2,pi,(3/2)*pi,2*pi),
    labels=c("0",expr_pi2,expr_pi,expr_3pi2,expr_2pi)
  )
reg_tree_plot
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: constant-guess
library(ggtext)
# x_lt_pi = data_df |> filter(x < pi)
# mean(x_lt_pi$y)
data_df <- data_df |> mutate(
  pred_sq_err0 = (y - 0)^2
)
mse0 <- mean(data_df$pred_sq_err0)
mse0_str <- sprintf("%.3f", mse0)
reg_tree_plot +
  geom_hline(
    yintercept = 0,
    color=cbPalette[1],
    linewidth = g_linewidth
  ) +
  geom_segment(
    aes(x=x, xend=x, y=0, yend=y)
  ) +
  geom_text(
    aes(x=(3/2)*pi, y=0.5, label=paste0("MSE = ",mse0_str)),
    size = 10,
    #box.padding = unit(c(2,2,2,2), "pt")
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: one-level-tree
#| fig-height: 3.5
get_y_pred <- function(x) ifelse(x < pi, 2/pi, -2/pi)
data_df <- data_df |> mutate(
  pred_sq_err1 = (y - get_y_pred(x))^2
)
mse1 <- mean(data_df$pred_sq_err1)
mse1_str <- sprintf("%.3f", mse1)
decision_df <- tribble(
  ~x, ~xend, ~y, ~yend,
  0, pi, 2/pi, 2/pi,
  pi, 2*pi, -2/pi, -2/pi
)
reg_tree_plot +
  geom_segment(
    data=decision_df,
    aes(x=x, xend=xend, y=y, yend=yend),
    color=cbPalette[1],
    linewidth = g_linewidth
  ) +
  geom_segment(
    aes(x=x, xend=x, y=get_y_pred(x), yend=y)
  ) +
  geom_text(
    aes(x=(3/2)*pi, y=0.5, label=paste0("MSE = ",mse1_str)),
    size = 9,
    #box.padding = unit(c(2,2,2,2), "pt")
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: one-level-ternary
#| fig-height: 3.5
cut1 <- (2/3) * pi
cut2 <- (4/3) * pi
pos_mean <- 9 / (4*pi)
get_y_pred <- function(x) ifelse(x < cut1, pos_mean, ifelse(x < cut2, 0, -pos_mean))
data_df <- data_df |> mutate(
  pred_sq_err1b = (y - get_y_pred(x))^2
)
mse1b <- mean(data_df$pred_sq_err1b)
mse1b_str <- sprintf("%.3f", mse1b)
decision_df <- tribble(
  ~x, ~xend, ~y, ~yend,
  0, (2/3)*pi, pos_mean, pos_mean,
  (2/3)*pi, (4/3)*pi, 0, 0,
  (4/3)*pi, 2*pi, -pos_mean, -pos_mean
)
reg_tree_plot +
  geom_segment(
    data=decision_df,
    aes(x=x, xend=xend, y=y, yend=yend),
    color=cbPalette[1],
    linewidth = g_linewidth
  ) +
  geom_segment(
    aes(x=x, xend=x, y=get_y_pred(x), yend=y)
  ) +
  geom_text(
    aes(x=(3/2)*pi, y=0.5, label=paste0("MSE = ",mse1b_str)),
    size = 9,
    #box.padding = unit(c(2,2,2,2), "pt")
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: one-level-ternary-uneven
#| fig-height: 3.5
c <- 0.113
cut1 <- (1 - c) * pi
cut2 <- (1 + c) * pi
pos_mean <- 0.695
get_y_pred <- function(x) ifelse(x < cut1, pos_mean, ifelse(x < cut2, 0, -pos_mean))
data_df <- data_df |> mutate(
  pred_sq_err1b = (y - get_y_pred(x))^2
)
mse1b <- mean(data_df$pred_sq_err1b)
mse1b_str <- sprintf("%.3f", mse1b)
decision_df <- tribble(
  ~x, ~xend, ~y, ~yend,
  0, cut1, pos_mean, pos_mean,
  cut1, cut2, 0, 0,
  cut2, 2*pi, -pos_mean, -pos_mean
)
reg_tree_plot +
  geom_segment(
    data=decision_df,
    aes(x=x, xend=xend, y=y, yend=yend),
    color=cbPalette[1],
    linewidth = g_linewidth
  ) +
  geom_segment(
    aes(x=x, xend=x, y=get_y_pred(x), yend=y)
  ) +
  geom_text(
    aes(x=(3/2)*pi, y=0.5, label=paste0("MSE = ",mse1b_str)),
    size = 9,
    #box.padding = unit(c(2,2,2,2), "pt")
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: misclass-plot
library(tidyverse)
library(latex2exp)
my_mc <- function(p) 0.5 - abs(0.5 - p)
x_vals <- seq(0, 1, 0.01)
mc_vals <- sapply(x_vals, my_mc)
phat_label <- TeX('$\\widehat{p}$')
data_df <- tibble(x=x_vals, loss_mc=mc_vals)
ggplot(data_df, aes(x=x, y=loss_mc)) +
  geom_line(linewidth = g_linewidth) +
  dsan_theme("half") +
  labs(
    x = phat_label,
    y = "Misclassification Loss"
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: entropy-vs-gini
library(tidyverse)
library(latex2exp)
phat_label <- TeX('$\\widehat{p}')
my_ent <- function(p) -(p*log2(p) + (1-p)*log2(1-p))
my_gini <- function(p) 4*p*(1-p)
x_vals <- seq(0.01, 0.99, 0.01)
ent_vals <- sapply(x_vals, my_ent)
ent_df <- tibble(x=x_vals, y=ent_vals, Measure="Entropy")
gini_vals <- sapply(x_vals, my_gini)
gini_df <- tibble(x=x_vals, y=gini_vals, Measure="Gini")
data_df <- bind_rows(ent_df, gini_df)
ggplot(data=data_df, aes(x=x, y=y, color=Measure)) +
  geom_line(linewidth = g_linewidth) +
  dsan_theme("half") +
  scale_color_manual(values=c(cbPalette[1], cbPalette[2])) +
  labs(
    x = phat_label,
    y = "Measure Value",
    title = "Entropy vs. Gini Coefficient"
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: ski-plot-binary
#| fig-cap: "*(Example adapted from CS229: Machine Learning, Stanford University)*"
library(tidyverse)
library(lubridate)
sample_size <- 100
day <- seq(ymd('2023-01-01'),ymd('2023-12-31'),by='weeks')
lat_bw <- 5
latitude <- seq(-90, 90, by=lat_bw)
ski_df <- expand_grid(day, latitude)
ski_df <- tibble::rowid_to_column(ski_df, var='obs_id')
#ski_df |> head()
# Data-generating process
lat_cutoff <- 35
ski_df <- ski_df |> mutate(
  near_equator = abs(latitude) <= lat_cutoff,
  northern = latitude > lat_cutoff,
  southern = latitude < -lat_cutoff,
  first_3m = day < ymd('2023-04-01'),
  last_3m = day >= ymd('2023-10-01'),
  middle_6m = (day >= ymd('2023-04-01')) & (day < ymd('2023-10-01')),
  snowfall = 0
)
# Update the non-zero sections
mu_snow <- 10
sd_snow <- 2.5
# How many northern + first 3 months
num_north_first_3 <- nrow(ski_df[ski_df$northern & ski_df$first_3m,])
ski_df[ski_df$northern & ski_df$first_3m, 'snowfall'] = rnorm(num_north_first_3, mu_snow, sd_snow)
# Northerns + last 3 months
num_north_last_3 <- nrow(ski_df[ski_df$northern & ski_df$last_3m,])
ski_df[ski_df$northern & ski_df$last_3m, 'snowfall'] = rnorm(num_north_last_3, mu_snow, sd_snow)
# How many southern + middle 6 months
num_south_mid_6 <- nrow(ski_df[ski_df$southern & ski_df$middle_6m,])
ski_df[ski_df$southern & ski_df$middle_6m, 'snowfall'] = rnorm(num_south_mid_6, mu_snow, sd_snow)
# And collapse into binary var
ski_df['good_skiing'] = ski_df$snowfall > 0
# This converts day into an int
ski_df <- ski_df |> mutate(
  day_num = lubridate::yday(day)
)
#print(nrow(ski_df))
ski_sample <- ski_df |> slice_sample(n = sample_size)
ski_sample |> write_csv("assets/ski.csv")
month_vec <- c(ymd('2023-01-01'), ymd('2023-02-01'), ymd('2023-03-01'), ymd('2023-04-01'), ymd('2023-05-01'), ymd('2023-06-01'), ymd('2023-07-01'), ymd('2023-08-01'), ymd('2023-09-01'), ymd('2023-10-01'), ymd('2023-11-01'), ymd('2023-12-01'))
month_labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
ggplot(
  ski_sample,
  aes(
    x=day,
    y=latitude,
    #shape=good_skiing,
    color=good_skiing
  )) +
  geom_point(
    size = g_pointsize / 1.5,
    #stroke=1.5
  ) +
  dsan_theme() +
  labs(
    x = "Time of Year",
    y = "Latitude",
    shape = "Good Skiing?"
  ) +
  scale_shape_manual(name="Good Skiing?", values=c(1, 3)) +
  scale_color_manual(name="Good Skiing?", values=c(cbPalette[1], cbPalette[2]), labels=c("No (Sunny)","Yes (Snowy)")) +
  scale_x_continuous(
    breaks=month_vec,
    labels=month_labels
  ) +
  scale_y_continuous(breaks=c(-90, -60, -30, 0, 30, 60, 90))
#
#
#
#
#
#
#
#
#| label: ski-zero-splits
ski_sample |> count(good_skiing)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: ski-split-latitude
#| fig-align: center
#| classes: fwt
ski_sample <- ski_sample |> mutate(
  lat_lt_n425 = latitude < -42.5
)
r1a <- ski_sample |> filter(lat_lt_n425) |> summarize(
  good_skiing = sum(good_skiing),
  total = n()
) |> mutate(region = "R1(A)", .before=good_skiing)
r2a <- ski_sample |> filter(lat_lt_n425 == FALSE) |> summarize(
  good_skiing = sum(good_skiing),
  total = n()
) |> mutate(region = "R2(A)", .before=good_skiing)
choice_a_df <- bind_rows(r1a, r2a)
choice_a_df
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: ski-split-month
#| classes: fwt
ski_sample <- ski_sample |> mutate(
  month_lt_oct = day < ymd('2023-10-01')
)
r1b <- ski_sample |> filter(month_lt_oct) |> summarize(
  good_skiing = sum(good_skiing),
  total = n()
) |> mutate(region = "R1(B)", .before=good_skiing)
r2b <- ski_sample |> filter(month_lt_oct == FALSE) |> summarize(
  good_skiing = sum(good_skiing),
  total = n()
) |> mutate(region = "R2(B)", .before=good_skiing)
choice_b_df <- bind_rows(r1b, r2b)
choice_b_df
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: sklearn-ski-results
library(tidyverse)
library(arrow)
# Load the dataset
ski_result_df <- read_csv("assets/ski_predictions.csv")
# Merge dates back in
ski_sample_day_df <- ski_sample |> select(obs_id, day)
ski_result_df <- ski_result_df |> left_join(ski_sample_day_df, by='obs_id')
# Load the DT info
dt_df <- read_feather("assets/ski_dt.feather")
# Here we only have one value, so just read that
# value directly
lat_thresh <- dt_df$feat_threshold
# And here we convert month_vec into a vector of
# day numbers
day_num_vec <- sapply(month_vec, lubridate::yday)
ggplot() +
  geom_point(
    data=ski_result_df,
    aes(x=day_num, y=latitude, color=factor(good_skiing), shape=correct),
    size = g_pointsize / 1.5,
    stroke = 1.5
  ) +
  geom_hline(
    yintercept = lat_thresh,
    linetype = "dashed"
  ) +
  geom_rect(
    aes(xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=-42.5, fill='R1'),
    alpha=0.1
  ) +
  geom_rect(
    aes(xmin=-Inf, xmax=Inf, ymin=-42.5, ymax=Inf, fill='R2'),
    alpha=0.1
  ) +
  dsan_theme("half") +
  labs(
    x = "Time of Year",
    y = "Latitude",
    color = "True Class",
    #shape = "Correct?"
  ) +
  scale_shape_manual("DT Result", values=c(1,3), labels=c("Incorrect","Correct")) +
  scale_fill_manual("DT Prediction", values=c(cbPalette[4], cbPalette[5])) +
  scale_color_manual("True Class", values=c(cbPalette[1], cbPalette[2]), labels=c("Bad (Sunny)","Good (Snowy)")) +
  scale_x_continuous(
    breaks=day_num_vec,
    labels=month_label_vec
  )
#
#
#
#
#
#| label: ski-acc-vs-entropy
ski_result_df |> count(correct)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
