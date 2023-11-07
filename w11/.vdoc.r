#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: gdp-plot
#| warning: false
#| fig-width: 10
#| fig-height: 4
library(readr)
library(ggplot2)
gdp_df <- read_csv("assets/gdp_pca.csv")

dist_to_line <- function(x0, y0, a, c) {
    numer <- abs(a * x0 - y0 + c)
    denom <- sqrt(a * a + 1)
    return(numer / denom)
}
# Finding PCA line for industrial vs. exports
x <- gdp_df$industrial
y <- gdp_df$exports
lossFn <- function(lineParams, x0, y0) {
    a <- lineParams[1]
    c <- lineParams[2]
    return(sum(dist_to_line(x0, y0, a, c)))
}
o <- optim(c(0, 0), lossFn, x0 = x, y0 = y)
ggplot(gdp_df, aes(x = industrial, y = exports)) +
    geom_point(size=g_pointsize/2) +
    geom_abline(aes(slope = o$par[1], intercept = o$par[2], color="pca"), linewidth=g_linewidth, show.legend = TRUE) +
    geom_smooth(aes(color="lm"), method = "lm", se = FALSE, linewidth=g_linewidth, key_glyph = "blank") +
    scale_color_manual(element_blank(), values=c("pca"=cbPalette[2],"lm"=cbPalette[1]), labels=c("Regression","PCA")) +
    dsan_theme("half") +
    remove_legend_title() +
    labs(
      title = "PCA Line vs. Regression Line",
	    x = "Industrial Production (% of GDP)",
	    y = "Exports (% of GDP)"
    )
#
#
#
#| label: pca-plot
#| warning: false
#| fig-width: 10
#| fig-height: 4
ggplot(gdp_df, aes(pc1, .fittedPC2)) +
    geom_point(size = g_pointsize/2) +
    geom_hline(aes(yintercept=0, color='PCA Line'), linetype='solid', size=g_linesize) +
    geom_rug(sides = "b", linewidth=g_linewidth/1.2, length = unit(0.1, "npc"), color=cbPalette[3]) +
    expand_limits(y=-1.6) +
    scale_color_manual(element_blank(), values=c("PCA Line"=cbPalette[2])) +
    dsan_theme("half") +
    remove_legend_title() +
    labs(
      title = "Exports vs. Industry in Principal Component Space",
      x = "First Principal Component (Axis of Greatest Variance)",
      y = "Second PC"
    )
#
#
#
#
#
#| label: pca-facet-plot
#| warning: false
#| fig-height: 4
#| fig-width: 17
library(dplyr)
library(tidyr)
plot_df <- gdp_df %>% select(c(country_code, pc1, agriculture, military))
long_df <- plot_df %>% pivot_longer(!c(country_code, pc1), names_to = "var", values_to = "val")
long_df <- long_df |> mutate(
  var = case_match(
    var,
    "agriculture" ~ "Agricultural Production",
    "military" ~ "Military Spending"
  )
)
ggplot(long_df, aes(x = pc1, y = val, facet = var)) +
    geom_point() +
    facet_wrap(vars(var), scales = "free") +
	dsan_theme("full") +
	labs(
		x = "Industrial-Export Dimension (First Principal Component)",
		y = "% of GDP"
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
#| label: pca-dgp-no-covar
library(tidyverse)
library(MASS)
library(ggforce)
N <- 250
Mu <- c(0, 0)
var_x <- 3
var_y <- 1
Sigma <- matrix(c(var_x, 0, 0, var_y), nrow=2)
data_df <- as_tibble(mvrnorm(N, Mu, Sigma))
colnames(data_df) <- c("x","y")
# data_df <- data_df |> mutate(
#   within_5 = x < 5,
#   within_sq5 = x < sqrt(5)
# )
#nrow(data_df |> filter(within_5)) / nrow(data_df)
#nrow(data_df |> filter(within_sq5)) / nrow(data_df)
# And plot
ggplot(data_df, aes(x=x, y=y)) +
  # 68% ellipse
  # stat_ellipse(geom="polygon", type="norm", linewidth=g_linewidth, level=0.68, fill=cbPalette[1], alpha=0.5) +
  # stat_ellipse(type="norm", linewidth=g_linewidth, level=0.68) +
  geom_ellipse(
    aes(x0=0, y0=0, a=var_x, b=var_y, angle=0),
    linewidth = g_linewidth
  ) +
  # geom_ellipse(
  #   aes(x0=0, y0=0, a=sqrt(5), b=1, angle=0),
  #   linewidth = g_linewidth,
  #   geom="polygon",
  #   fill=cbPalette[1], alpha=0.2
  # ) +
  # # 95% ellipse
  # stat_ellipse(geom="polygon", type="norm", linewidth=g_linewidth, level=0.95, fill=cbPalette[1], alpha=0.25) +
  # stat_ellipse(type="norm", linewidth=g_linewidth, level=0.95) +
  # # 99.7% ellipse
  # stat_ellipse(geom='polygon', type="norm", linewidth=g_linewidth, level=0.997, fill=cbPalette[1], alpha=0.125) +
  # stat_ellipse(type="norm", linewidth=g_linewidth, level=0.997) +
  # Lines at x=0 and y=0
  geom_vline(xintercept=0, linetype="dashed", linewidth=g_linewidth) +
  geom_hline(yintercept=0, linetype="dashed", linewidth = g_linewidth) +
  geom_point(
    size = g_pointsize / 2.5,
    #alpha=0.5
  ) +
  geom_rug(length=unit(0.5, "cm")) +
  geom_segment(
    aes(x=-var_x, y=0, xend=var_x, yend=0, color='PC1'),
    linewidth = g_linewidth,
    arrow = arrow(length = unit(0.1, "npc"))
  ) +
  geom_segment(
    aes(x=0, y=-var_y, xend=0, yend=var_y, color='PC2'),
    linewidth = g_linewidth,
    arrow = arrow(length = unit(0.1, "npc"))
  ) +
  dsan_theme() +
  coord_fixed() +
  remove_legend_title() +
  scale_color_manual(
    "PC Vectors",
    values=c('PC1'=cbPalette[1], 'PC2'=cbPalette[2])
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
#| label: pca-dgp
library(tidyverse)
library(MASS)
N <- 250
Mu <- c(0,0)
Sigma <- matrix(c(2,1,1,2), nrow=2)
data_df <- as_tibble(mvrnorm(N, Mu, Sigma))
colnames(data_df) <- c("x","y")
ggplot(data_df, aes(x=x, y=y)) +
  geom_ellipse(
    aes(x0=0, y0=0, a=var_x, b=var_y, angle=pi/4),
    linewidth = g_linewidth
  ) +
  geom_vline(xintercept=0, linetype="dashed", linewidth=g_linewidth) +
  geom_hline(yintercept=0, linetype="dashed", linewidth = g_linewidth) +
  geom_point(size = g_pointsize / 2) +
  geom_segment(
    aes(x=-var_x, y=0, xend=var_x, yend=0, color='PC1'),
    linewidth = g_linewidth,
    arrow = arrow(length = unit(0.1, "npc"))
  ) +
  geom_segment(
    aes(x=0, y=-var_y, xend=0, yend=var_y, color='PC2'),
    linewidth = g_linewidth,
    arrow = arrow(length = unit(0.1, "npc"))
  ) +
  dsan_theme() +
  coord_fixed()
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
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
day <- seq(ymd('2023-01-01'),ymd('2023-12-31'),by='weeks')
longitude <- seq(-90, 90, by=5)
ski_df <- expand_grid(day, longitude)
#ski_df |> head()
# Data-generating process
ski_df <- ski_df |> mutate(
  near_equator = abs(longitude) <= 30,
  northern = longitude > 30,
  southern = longitude < -30,
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
ski_sample <- ski_df |> sample_n(100)
ski_sample |> write_csv("assets/ski.csv")
ggplot(ski_sample, aes(x=day, y=longitude, shape=good_skiing, color=good_skiing)) +
  geom_point(
    size = g_pointsize / 2, stroke=1.5,
  ) +
  dsan_theme() +
  labs(
    x = "Time of Year",
    y = "Longitude",
    shape = "Good Skiing?"
  ) +
  scale_shape_manual(name="Good Skiing?", values=c(1, 3)) +
  scale_color_manual(name="Good Skiing?", values=c(cbPalette[1], cbPalette[2])) +
  scale_x_continuous(
    breaks=c(ymd('2023-01-01'), ymd('2023-02-01'), ymd('2023-03-01'), ymd('2023-04-01'), ymd('2023-05-01'), ymd('2023-06-01'), ymd('2023-07-01'), ymd('2023-08-01'), ymd('2023-09-01'), ymd('2023-10-01'), ymd('2023-11-01'), ymd('2023-12-01')),
    labels=c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
  ) +
  scale_y_continuous(breaks=c(-90, -60, -30, 0, 30, 60, 90))
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
#| label: ski-split-longitude
#| fig-align: center
ski_sample <- ski_sample |> mutate(
  lon_gt_n30 = longitude >= -30
)
ski_sample |> group_by(lon_gt_n30) |> count(good_skiing)
#
#
#
#
#
#
#
#
#
#
#
#
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
ski_sample <- ski_sample |> mutate(
  month_lt_oct = day < ymd('2023-10-01')
)
ski_sample |> group_by(month_lt_oct) |> count(good_skiing)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: ski-plot-continuous
#| fig-cap: "*(Example adapted from CS229: Machine Learning, Stanford University)*"
#format_snow <- function(x) sprintf('%.2f', x)
format_snow <- function(x) round(x, 2)
ski_sample['snowfall_str'] <- sapply(ski_sample$snowfall, format_snow)
#ski_df |> head()
#print(nrow(ski_df))
ggplot(ski_sample, aes(x=day, y=longitude, label=snowfall_str)) +
  geom_text(size = 6) +
  dsan_theme() +
  labs(
    x = "Time of Year",
    y = "Longitude",
    shape = "Good Skiing?"
  ) +
  scale_shape_manual(values=c(1, 3)) +
  scale_x_continuous(
    breaks=c(ymd('2023-01-01'), ymd('2023-02-01'), ymd('2023-03-01'), ymd('2023-04-01'), ymd('2023-05-01'), ymd('2023-06-01'), ymd('2023-07-01'), ymd('2023-08-01'), ymd('2023-09-01'), ymd('2023-10-01'), ymd('2023-11-01'), ymd('2023-12-01')),
    labels=c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
  ) +
  scale_y_continuous(breaks=c(-90, -60, -30, 0, 30, 60, 90))
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
  geom_vline(
    xintercept = pi,
    linewidth = g_linewidth,
    linetype = "dashed"
  ) +
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
