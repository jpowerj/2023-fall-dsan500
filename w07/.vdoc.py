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
#
#
#
#| label: python-globals
cb_palette = ["#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7"]

from IPython.display import Markdown
def disp(df, floatfmt='g', include_index=True):
  return Markdown(
    df.to_markdown(
      floatfmt=floatfmt,
      index=include_index
    )
  )

def summary_to_df(summary_obj, corner_col = ''):
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
    reg_df.insert(loc=0, column=corner_col, value=index_col)
    # Sigh. Have to escape | characters?
    reg_df.columns = [c.replace("|","\|") for c in reg_df.columns]
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
