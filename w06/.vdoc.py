# type: ignore
# flake8: noqa
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: python-globals
cb_palette = ["#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7"]

from IPython.display import Markdown
def disp(df, floatfmt='g'):
  return Markdown(df.to_markdown(floatfmt=floatfmt))

def summary_to_df(summary_obj):
    reg_df = pd.DataFrame(summary_obj.tables[1].data)
    reg_df.columns = reg_df.iloc[0]
    reg_df = reg_df.iloc[1:].copy()
    # Save index col
    index_col = reg_df['']
    # Drop for now, so it's all numeric
    reg_df.drop(columns=[''], inplace=True)
    reg_df = reg_df.apply(pd.to_numeric)
    my_round = lambda x: round(x, 2)
    reg_df = reg_df.apply(my_round)
    numeric_cols = reg_df.columns
    # Add index col back in
    reg_df.insert(loc=0, column='', value=index_col)
    return reg_df
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: py-load-pop-data
#| echo: false
#| output: false
import pandas as pd
from IPython.display import Markdown
pop_df = pd.read_csv("assets/pop_2000.csv")
#
#
#
#| label: py-load-gdp-data
#| echo: false
gdp_df = pd.read_csv("assets/gdp_2000.csv")
#
#
#
#
#
#
#
#| label: py-merge
#| code-fold: show
merged_df = pop_df.merge(gdp_df,
  on='country', how='left', indicator=True
)
Markdown(merged_df.to_markdown())
#
#
#
#
#
#
#
#
#
#
#| label: py-merge-right
#| code-fold: show
merged_df = pop_df.merge(gdp_df,
  on='country', how='inner', indicator=True
)
Markdown(merged_df.to_markdown())
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: py-load-long-data
#| echo: false
#| output: false
long_df = pd.read_csv("assets/long_data.csv")
#
#
#
#
#
#| label: py-create-wide-id
#| code-fold: show
long_df['id'] = long_df['country'] + '_' + long_df['year'].apply(str)
# Reorder the columns, so it shows the id first
long_df = long_df[['id','country','year','type','count']]
disp(long_df.head(6))
#
#
#
#
#
#
#| label: py-long-to-wide
#| code-fold: show
reshaped_df = pd.pivot(long_df,
  index='id',
  columns='type',
  values='count'
)
disp(reshaped_df)
#
#
#
#
#
#
#
#
#
#
#
#| label: py-read-wide
#| code-fold: show
wide_df = pd.read_csv("assets/wide_data.csv")
disp(wide_df)
#
#
#
#
#
#
#| label: py-wide-to-long
#| code-fold: show
long_df = pd.melt(wide_df,
  id_vars=['country','year'],
  value_vars=['cases','population']
)
disp(long_df.head(6))
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: anscombe-quartet
#| fig-align: center
#| fig-height: 3
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
sns.set_theme(style="ticks")
# https://towardsdatascience.com/how-to-use-your-own-color-palettes-with-seaborn-a45bf5175146
sns.set_palette(sns.color_palette(cb_palette))

# Load the example dataset for Anscombe's quartet
anscombe_df = sns.load_dataset("anscombe")
#print(anscombe_df)

# Show the results of a linear regression within each dataset
anscombe_plot = sns.lmplot(
    data=anscombe_df, x="x", y="y", col="dataset", hue="dataset",
    col_wrap=4, palette="muted", ci=None,
    scatter_kws={"s": 50, "alpha": 1},
    height=3
);
anscombe_plot;
#
#
#
#
#
#| label: anscombe-again
#| echo: false
anscombe_plot
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: anscombe-means
# Compute dataset means
my_round = lambda x: round(x,2)
data_means = anscombe_df.groupby('dataset').agg(
  x_mean = ('x', np.mean),
  y_mean = ('y', np.mean)
).apply(my_round)
disp(data_means, floatfmt='.2f')
#
#
#
#
#
#
#
#
#| label: anscombe-sds
# Compute dataset SDs
data_sds = anscombe_df.groupby('dataset').agg(
  x_mean = ('x', np.std),
  y_mean = ('y', np.std),
).apply(my_round)
disp(data_sds, floatfmt='.2f')
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: anscombe-corrs
#| output: asis
#| classes: corr-table
import tabulate
from IPython.display import HTML
corr_matrix = anscombe_df.groupby('dataset').corr().apply(my_round)
#Markdown(tabulate.tabulate(corr_matrix))
HTML(corr_matrix.to_html())
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: anscombe-yet-again
#| echo: false
anscombe_plot
#
#
#
#| label: anscombe-regs
#| classes: corr-table
import statsmodels.formula.api as smf
ds1_df = anscombe_df.loc[anscombe_df['dataset'] == "I"].copy()
# Fit regression model (using the natural log of one of the regressors)
results = smf.ols('y ~ x', data=ds1_df).fit()

# Inspect the results
summary = results.summary()
summary.extra_txt = None
summary.tables[1]
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
