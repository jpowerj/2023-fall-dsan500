#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: linear-plot
#| fig-width: 6
#| fig-height: 5
library(tidyverse)
N <- 50
x_min <- 1
x_max <- 5
x_vals <- runif(N, x_min, x_max)
noise_vals <- rnorm(N, 0, exp(5))
my_exp <- function(x) exp(3*x + 1)
y_exp <- my_exp(x_vals) + noise_vals
exp_df <- tibble(x=x_vals, y=y_exp)
ggplot(exp_df) +
  stat_function(data=data.frame(x=c(x_min,x_max)), fun = my_exp, linewidth = g_linewidth, linetype="dashed") +
  geom_point(aes(x=x, y=y), size = g_pointsize / 2) +
  dsan_theme("half") +
  labs(
    title="y = exp(3x + 1), Linear Scale"
  )
#
#
#
#
#
#
#| label: exp-plot
#| fig-width: 6
#| fig-height: 5
# Log2 scaling of the y axis (with visually-equal spacing)
library(scales)
ggplot(exp_df) +
  stat_function(data=data.frame(x=c(x_min,x_max)), fun = my_exp, linewidth = g_linewidth, linetype="dashed") +
  geom_point(aes(x=x, y=y), size = g_pointsize / 2) +
  dsan_theme("half") +
  scale_y_continuous(trans = log_trans(),
    breaks = log_breaks()) +
  labs(
    title="y = exp(3x + 1), Log Scale"
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
#| label: collinear-cov-plot
#| fig-width: 3.8
#| fig-height: 3.8
library(tidyverse)
library(latex2exp)
gen_y_noisy <- function(x_val, eps) {
  lower <- max(-1, x_val - eps)
  upper <- min(1, x_val + eps)
  y_noisy <- runif(1, lower, upper)
  return(y_noisy)
}
N <- 100
x_vals <- runif(N, -1, 1)
x_mean <- mean(x_vals)
y_collinear <- x_vals
y_coll_mean <- mean(y_collinear, drop.na = TRUE)
df_collinear <- tibble(x=x_vals, y=y_collinear, rel="collinear")
# Force the points to be inside [-1,1]
y_noisy <- x_vals
for (i in 1:length(y_noisy)) {
  cur_x_val <- x_vals[i]
  y_noisy[i] <- gen_y_noisy(cur_x_val, 0.75)
}
y_noisy_mean <- mean(y_noisy, na.rm = TRUE)
#print(y_noisy_mean)
df_noisy <- tibble(x = x_vals, y = y_noisy, rel="noise")
# Label vals above and below mean
label_df <- tribble(
  ~x, ~y, ~label,
  0.5, 0.5, "+",
  -0.5, -0.5, "+",
  0.5, -0.5, "\u2212",
  -0.5, 0.5, "\u2212"
)
gen_cov_plot <- function(df) {
  x_mean = mean(df$x)
  y_mean = mean(df$y)
  ggplot(df, aes(x=x, y=y)) +
    geom_point() +
    geom_vline(xintercept = x_mean) +
    geom_hline(yintercept = y_mean) +
    #facet_grid(. ~ rel) + 
    geom_label(
      data=label_df,
      aes(x=x, y=y, label=label, color=label),
      alpha=0.75,
      size = g_pointsize * 1.5
    ) +
    scale_color_manual(values=c("darkgreen","red")) +
    dsan_theme() +
    remove_legend() +
    theme(
      #axis.text.x = element_blank(),
      axis.title.x = element_blank(),
      #axis.ticks.x = element_blank(),
      #axis.text.y = element_blank(),
      #axis.ticks.y = element_blank(),
      axis.title.y = element_blank()
    ) +
    xlim(c(-1,1)) + ylim(c(-1,1)) +
    coord_fixed(ratio=1) +
    scale_x_continuous(breaks=c(x_mean), labels=c(TeX(r"($\mu_x$)"))) +
    scale_y_continuous(breaks=c(y_mean), labels=c(TeX(r"($\mu_y$)")))
}
gen_cov_table <- function(df, print_matches = FALSE) {
  x_mean <- mean(df$x, na.rm = TRUE)
  y_mean <- mean(df$y, na.rm = TRUE)
  df <- df |> mutate(
    x_contrib = ifelse(x > x_mean, "+", "-"),
    y_contrib = ifelse(y > y_mean, "+", "-"),
    match = x_contrib == y_contrib
  )
  contrib_crosstab <- table(df$y_contrib, df$x_contrib)
  colnames(contrib_crosstab) <- c("x-", "x+")
  rownames(contrib_crosstab) <- c("y-", "y+")
  if (!print_matches) {
    print(contrib_crosstab)
  } else {
    # Num matches
    num_matches <- sum(df$match)
    num_mismatch <- nrow(df) - num_matches
    writeLines(paste0(num_matches, " matches, ",num_mismatch," mismatches"))
    writeLines("\nCovariance:")
    writeLines(paste0(cov(df$x, df$y)))
  }
}
gen_cov_plot(df_collinear)
#
#
#
#
#
#| label: collinear-cov-table
#| echo: false
gen_cov_table(df_collinear)
#
#
#
#| label: collinear-cov-matches
#| echo: false
gen_cov_table(df_collinear, print_matches = TRUE)
#
#
#
#
#
#
#
#
#| label: noisy-cov-plot
#| fig-align: center
#| fig-width: 3.8
#| fig-height: 3.8
gen_cov_plot(df_noisy)
#
#
#
#
#
#| label: cov-table-noisy
#| echo: false
gen_cov_table(df_noisy)
#
#
#
#| label: cov-matches-noisy
#| echo: false
gen_cov_table(df_noisy, print_matches = TRUE)
#
#
#
#
#
#
#
#
#| label: neg-cov-plot
#| fig-align: center
#| fig-width: 3.8
#| fig-height: 3.8
#| # Force the points to be inside [-1,1]
y_noisy_neg <- x_vals
for (i in 1:length(y_noisy_neg)) {
  cur_x_val <- x_vals[i]
  y_noisy_neg[i] <- -gen_y_noisy(cur_x_val, 0.75)
}
y_noisy_neg_mean <- mean(y_noisy_neg, na.rm = TRUE)
#print(y_noisy_mean)
df_noisy_neg <- tibble(x = x_vals, y = y_noisy_neg, rel="noise")
gen_cov_plot(df_noisy_neg)
#
#
#
#
#
#| label: neg-cov-table
#| echo: false
gen_cov_table(df_noisy_neg)
#
#
#
#| label: neg-cov-matches
#| echo: false
gen_cov_table(df_noisy_neg, print_matches = TRUE)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: collinear-rect-plot
#| fig-width: 3.8
#| fig-height: 3.8
gen_rect_plot <- function(df, col_order=c("red","darkgreen")) {
  x_mean = mean(df$x)
  y_mean = mean(df$y)
  df <- df |> mutate(
      x_contrib = ifelse(x > x_mean, "+", "-"),
      y_contrib = ifelse(y > y_mean, "+", "-"),
      match = x_contrib == y_contrib
  )
  ggplot(df, aes(x=x, y=y)) +
    geom_point() +
    geom_vline(xintercept = x_mean) +
    geom_hline(yintercept = y_mean) +
    #facet_grid(. ~ rel) + 
    geom_rect(aes(xmin=x_mean, xmax=x, ymin=y_mean, ymax=y, fill=match), color='black', linewidth=0.1, alpha=0.075) +
    scale_color_manual(values=c("darkgreen","red")) +
    scale_fill_manual(values=col_order) +
    geom_label(
      data=label_df,
      aes(x=x, y=y, label=label, color=label),
      alpha=0.75,
      size = g_pointsize * 1.5
    ) +
    dsan_theme() +
    remove_legend() +
    theme(
      #axis.text.x = element_blank(),
      axis.title.x = element_blank(),
      #axis.ticks.x = element_blank(),
      #axis.text.y = element_blank(),
      #axis.ticks.y = element_blank(),
      axis.title.y = element_blank()
    ) +
    xlim(c(-1,1)) + ylim(c(-1,1)) +
    coord_fixed(ratio=1) +
    scale_x_continuous(breaks=c(x_mean), labels=c(TeX(r"($\mu_x$)"))) +
    scale_y_continuous(breaks=c(y_mean), labels=c(TeX(r"($\mu_y$)")))
}
gen_rect_plot(df_collinear, col_order=c("darkgreen","red"))
#
#
#
#
#
#| label: collinear-rect-table
#| echo: false
gen_cov_table(df_collinear)
#
#
#
#| label: collinear-rect-matches
#| echo: false
gen_cov_table(df_collinear, print_matches = TRUE)
#
#
#
#
#
#
#
#
#| label: noisy-rect-plot
#| fig-align: center
#| fig-width: 3.8
#| fig-height: 3.8
gen_rect_plot(df_noisy)
#
#
#
#
#
#| label: noisy-rect-table
#| echo: false
gen_cov_table(df_noisy)
#
#
#
#| label: noisy-rect-matches
#| echo: false
gen_cov_table(df_noisy, print_matches = TRUE)
#
#
#
#
#
#
#
#
#| label: neg-rect-plot
#| fig-align: center
#| fig-width: 3.8
#| fig-height: 3.8
gen_rect_plot(df_noisy_neg)
#
#
#
#
#
#| label: neg-rect-table
#| echo: false
gen_cov_table(df_noisy_neg)
#
#
#
#| label: neg-rect-matches
#| echo: false
gen_cov_table(df_noisy_neg, print_matches = TRUE)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
sup_data <- tibble::tribble(
  ~home_id, ~sqft, ~bedrooms, ~rating,
  0, 1000, 1, "Disliked",
  1, 2000, 2, "Liked",
  2, 2500, 1, "Liked",
  3, 1500, 2, "Disliked",
  4, 2200, 1, "Liked"
)
#
#
#
#
sup_data
```
#
#
#
#
#
#
#
unsup_data <- tibble::tribble(
  ~home_id, ~sqft, ~bedrooms,
  0, 1000, 1,
  1, 2000, 2,
  2, 2500, 1,
  3, 1500, 2,
  4, 2200, 1
)
#
#
#
#
unsup_data
```
#
#
#
#
#
#
#
#
#
ggplot(sup_data, aes(x=sqft, y=bedrooms, color=rating)) + 
  geom_point(size=g_pointsize) +
  labs(
    title = "Supervised Data: House Listings",
    x = "Square Footage",
    y = "Number of Bedrooms",
    color = "Outcome"
  ) +
  expand_limits(x=c(800,2700), y=c(0.8,2.2)) +
  global_theme
```
#
#
#
#
# To force a legend
unsup_grouped <- unsup_data %>% mutate(big=bedrooms > 1)
unsup_grouped[['big']] <- factor(unsup_grouped[['big']], labels=c("?1","?2"))
ggplot(unsup_grouped, aes(x=sqft, y=bedrooms, fill=big)) + 
  geom_point(size=g_pointsize) +
  labs(
    x = "Square Footage",
    y = "Number of Bedrooms",
    fill = "?"
  ) +
  global_theme +
  expand_limits(x=c(800,2700), y=c(0.8,2.2)) +
  ggtitle("Unsupervised Data: House Listings") +
  theme(legend.background = element_rect(fill="white", color="white"), legend.box.background = element_rect(fill="white"), legend.text = element_text(color="white"), legend.title = element_text(color="white"), legend.position = "right") +
  scale_fill_discrete(labels=c("?","?")) +
  #scale_color_discrete(values=c("white","white"))
  scale_color_manual(name=NULL, values=c("white","white")) +
  #scale_color_manual(values=c("?1"="white","?2"="white"))
  guides(fill = guide_legend(override.aes = list(shape = NA)))
```
#
#
#
#
#
#
#
#
ggplot(sup_data, aes(x=sqft, y=bedrooms, color=rating)) + 
  geom_point(size=g_pointsize) +
  labs(
    title = "Supervised Data: House Listings",
    x = "Square Footage",
    y = "Number of Bedrooms",
    color = "Outcome"
  ) +
  global_theme +
  expand_limits(x=c(800,2700), y=c(0.8,2.2)) +
  geom_vline(xintercept = 1750, linetype="dashed", color = "black", size=1) +
  annotate('rect', xmin=-Inf, xmax=1750, ymin=-Inf, ymax=Inf, alpha=.2, fill=cbPalette[1]) +
  annotate('rect', xmin=1750, xmax=Inf, ymin=-Inf, ymax=Inf, alpha=.2, fill=cbPalette[2])
  #geom_rect(aes(xmin=-Inf, xmax=Inf, ymin=0, ymax=Inf, alpha=.2, fill='red'))
```
#
#
#
#
ggplot(unsup_grouped, aes(x=sqft, y=bedrooms)) +
  #scale_color_brewer(palette = "PuOr") +
  geom_mark_ellipse(expand=0.1, aes(fill=big), size = 1) +
  geom_point(size=g_pointsize) +
  labs(
    x = "Square Footage",
    y = "Number of Bedrooms",
    fill = "?"
  ) +
  global_theme +
  ggtitle("Unsupervised Data: House Listings") +
  #theme(legend.position = "none") +
  #theme(legend.title = text_element("?"))
  expand_limits(x=c(800,2700), y=c(0.8,2.2)) +
  scale_fill_manual(values=c(cbPalette[3],cbPalette[4]), labels=c("?","?"))
  #scale_fill_manual(labels=c("?","?"))
```
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
