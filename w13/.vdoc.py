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
import networkx as nx
B = nx.complete_bipartite_graph(4, 5)
pos = nx.bipartite_layout(B)
top = networkx.bipartite.sets(B)[0]
pos = networkx.bipartite_layout(B, top)
networkx.draw(B, pos=pos, with_labels=True, node_color=['green','green','green','green','blue','blue','blue'])
plt.show()
#
#
#
#
#
#
#
