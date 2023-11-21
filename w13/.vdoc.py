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
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: networkx-intro
#| output-location: column
#| code-fold: show
import networkx as nx
import matplotlib.pyplot as plt
G = nx.DiGraph()
G.add_nodes_from(
    [("Bulbasaur", dict(subset=1)), ("Ivysaur", dict(subset=1)), ("Venusaur", dict(subset=1)),
     ("Charmander", dict(subset=2)), ("Charmeleon", dict(subset=2)), ("Charizard", dict(subset=2)),
     ("Squirtle", dict(subset=3)), ("Wartortle", dict(subset=3)), ("Blastoise", dict(subset=3)),
     ("Farfetch'd", dict(subset=4))]
)
G.add_edge("Bulbasaur", "Ivysaur", weight=16)
G.add_edge("Ivysaur", "Venusaur", weight=32)
G.add_edge("Charmander", "Charmeleon", weight=16)
G.add_edge("Charmeleon", "Charizard", weight=36)
G.add_edge("Squirtle", "Wartortle", weight=16)
G.add_edge("Wartortle", "Blastoise", weight=36)
plt.figure(figsize=(6,7))
#layout = nx.circular_layout(G)
#layout = nx.spiral_layout(G)
#layout = nx.kamada_kawai_layout(G)
#layout = nx.random_layout(G)
#layout = nx.shell_layout(G)
layout = nx.multipartite_layout(G)
nx.draw_networkx_nodes(G, layout, node_size=4000, node_color='white', edgecolors='black')
nx.draw_networkx_labels(G, layout, font_size=10);
nx.draw_networkx_edges(G, layout, node_size=4000, arrows=True, arrowsize=30)
#layout = nx.draw_circular(G, with_labels=True, node_size=2500, arrowsize=25)
edge_labels = nx.get_edge_attributes(G, "weight")
nx.draw_networkx_edge_labels(G, layout, edge_labels);
plt.margins(x=0.2, y=0.1)
plt.show()
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: fully-connected-graph
import networkx as nx
import matplotlib.pyplot as plt
complete = nx.complete_graph(5)
nx.draw_circular(
  complete, with_labels = True,
  node_color = 'lightblue',
  node_size = 3000,
  font_size = 32
)
plt.tight_layout()
plt.show()
#
#
#
#
#
#
#
#
#
#
#
import networkx as nx
import matplotlib.pyplot as plt
B = nx.complete_bipartite_graph(4, 5)
top = nx.bipartite.sets(B)[0]
pos = nx.bipartite_layout(B, top)
nx.draw(
  B, pos=pos, with_labels=True,
  node_color = 'lightblue',
  node_size = 4000,
  font_size = 32
)
plt.margins(y=0.1)
plt.show()
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: path-graph
import networkx as nx
import matplotlib.pyplot as plt
path_graph = nx.path_graph(5)
nx.draw(
  path_graph, with_labels = True,
  node_color = 'lightblue',
  node_size = 4500,
  font_size = 32
)
plt.margins(y=0.1)
plt.show()
#
#
#
#
#
#
#
#
#
#
#| label: cycle-graph
import networkx as nx
import matplotlib.pyplot as plt
path_graph = nx.cycle_graph(5)
nx.draw(
  path_graph, with_labels = True,
  node_color = 'lightblue',
  node_size = 4500,
  font_size = 32
)
plt.margins(y=0.1)
plt.show()
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: market-basket-network-plot
#| fig-width: 6
import numpy as np
np.random.seed(5000)
basket_graph = nx.Graph()
nodes = ['Milk','Bread','Butter','Beer','Diapers','Eggs','Fruit']
basket_graph.add_edge('Milk','Bread',weight=2)
basket_graph.add_edge('Milk','Fruit',weight=2)
basket_graph.add_edge('Bread','Fruit',weight=2)
basket_graph.add_edge('Butter','Eggs',weight=2)
basket_graph.add_edge('Butter','Fruit',weight=2)
basket_graph.add_edge('Eggs','Fruit',weight=2)
basket_graph.add_edge('Beer','Diapers',weight=1)
basket_graph.add_edge('Milk','Butter',weight=1)
basket_graph.add_edge('Milk','Eggs',weight=1)
basket_graph.add_edge('Bread','Butter',weight=1)
basket_graph.add_edge('Bread','Eggs',weight=1)
spring_pos = nx.spring_layout(
  basket_graph,
  pos = {'Fruit': (0.4,0.3), 'Beer': (0.4,0.7)},
  fixed = ['Fruit','Beer'],
  seed = 5000
)
nx.draw(
  basket_graph, spring_pos, with_labels=True,
  #node_color = 'lightblue',
  node_size = 1000,
  font_size = 14,
  node_shape="s",  node_color="none",
  bbox=dict(facecolor="skyblue", edgecolor='black', boxstyle='round,pad=0.2')
)
plt.gca().set_aspect('equal')
plt.margins(x = 0.4)
plt.show()
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dataset = [['Milk', 'Onion', 'Nutmeg', 'Kidney Beans', 'Eggs', 'Yogurt'],
           ['Onion', 'Nutmeg', 'Kidney Beans', 'Eggs', 'Yogurt'],
           ['Milk', 'Apple', 'Kidney Beans', 'Eggs'],
           ['Milk', 'Corn', 'Kidney Beans', 'Yogurt'],
           ['Corn', 'Onion', 'Onion', 'Kidney Beans', 'Ice cream', 'Eggs']]
import pandas as pd
from mlxtend.preprocessing import TransactionEncoder

te = TransactionEncoder()
te_ary = te.fit(dataset).transform(dataset)
df = pd.DataFrame(te_ary, columns=te.columns_)
disp(df)
#
#
#
#
#
#
#
#
#| label: apriori-support-threshold
#| code-fold: show
from mlxtend.frequent_patterns import apriori
apriori_df = apriori(df, min_support=0.6, use_colnames=True)
apriori_df['length'] = apriori_df['itemsets'].apply(len)
format_dict = {
  'support': lambda x: format(x, '.2f'),
  'itemsets': ', '.join
}
#
#
#
#
#
#
apriori_df.style.format(format_dict)
#
#
#
#
#
#
#
#
#| label: filter-apriori
#| code-fold: show
rules_df = apriori_df[ (apriori_df['length'] >= 2) & (apriori_df['support'] >= 0.8) ].copy()
rules_df.style.format(format_dict)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
