#
#
#| label: centroid-plot
#| fig-height: 7
N <- 250
x_coords <- runif(N, 0, 1)
y_coords <- runif(N, 0, 1 - x_coords)
data_df <- tibble(x=x_coords, y=y_coords)
cent_x <- mean(x_coords)
cent_y <- mean(y_coords)
cent_df <- tibble(x=cent_x, y=cent_y)
triangle_plot <- ggplot(
    data_df,
    aes(x=x, y=y)
  ) +
  geom_point(
    size = g_pointsize / 2,
    color=cbPalette[1]
  ) +
  geom_point(
    data=cent_df,
    aes(x=x, y=y),
    shape=4, stroke=4, color='black',
    size = g_pointsize * 1.5) +
  geom_point(
    data=cent_df,
    aes(x=x, y=y),
    shape=19, color='white',
    size = g_pointsize / 2) +
  dsan_theme('quarter')
# Now a rectangle
x_coords_rect <- runif(N, 0.5, 1)
y_coords_rect <- runif(N, 0.5, 1)
rect_df <- tibble(x=x_coords_rect, y=y_coords_rect)
cent_x_rect <- mean(x_coords_rect)
cent_y_rect <- mean(y_coords_rect)
cent_df_rect <- tibble(x=cent_x_rect, y=cent_y_rect)
rect_plot <- triangle_plot +
  geom_point(
    data=rect_df,
    aes(x=x, y=y),
    size = g_pointsize / 2,
    color=cbPalette[2]
  ) +
  geom_point(
    data=cent_df_rect,
    aes(x=x, y=y),
    shape=4, stroke=4, color='black',
    size = g_pointsize * 1.5) +
  geom_point(
    data=cent_df_rect,
    aes(x=x, y=y),
    shape=19, color='white',
    size = g_pointsize / 2) +
  dsan_theme('half') +
  labs(
    title = "Centroids for N=250 Points"
  )
rect_plot 
#
#
#
#
