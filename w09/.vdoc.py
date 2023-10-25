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
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: gaussian-mixture-mle
#| output: false
#| code-fold: show
import pandas as pd
import numpy as np
import sklearn
sklearn.set_config(display = 'text')
from sklearn.mixture import GaussianMixture
cluster_df = pd.read_csv("assets/cluster_data.csv")
X = cluster_df[['x','y']].values
estimator = GaussianMixture(n_components=2, covariance_type="spherical", max_iter=20, random_state=5000);
estimator.fit(X);
y_pred = estimator.predict(X)
# Gather everything into a .csv
# The estimated means
mean_df = pd.DataFrame(estimator.means_).transpose()
mean_df.columns = ['x','y']
mean_df['Estimated Centroid'] = ['mu1','mu2']
mean_df['Estimated Cluster'] = ['E1', 'E2']
mean_df['Estimated Cluster Mapped'] = ['C1', 'C2']
cov_array = estimator.covariances_
sigma1 = np.sqrt(cov_array[0])
sigma2 = np.sqrt(cov_array[1])
mean_df['Estimated Sigma'] = [sigma1,sigma2]
mean_df['Estimated 2Sigma'] = [2*sigma1, 2*sigma2]
mean_df['Estimated 3Sigma'] = [3*sigma1, 3*sigma2]
mean_df.to_csv("assets/sklearn_mean_df.csv", index=False)
# The estimated covariance matrix
cov_df = pd.DataFrame({'c1': [1, cov_array[0]], 'c2': [cov_array[1], 1]})
cov_df.to_csv("assets/sklearn_cov_df.csv", index=False)
# And the predicted clusters
pred_df = pd.DataFrame({'Estimated Cluster': y_pred})
pred_df['Estimated Cluster'] = pred_df['Estimated Cluster'].apply(lambda x: 'E1' if x == 0 else 'E2')
pred_df['Estimated Cluster Mapped'] = pred_df['Estimated Cluster'].apply(lambda x: 'C1' if x == 'E1' else 'C2')
pred_df.to_csv("assets/sklearn_pred_df.csv", index=False)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: sklearn-kmc
#| fig-cap: Adapted from [Scikit-learn User Guide](https://scikit-learn.org/stable/auto_examples/cluster/plot_kmeans_digits.html#sphx-glr-auto-examples-cluster-plot-kmeans-digits-py){target='_blank'}
import pandas as pd
import matplotlib.colors
from sklearn.cluster import KMeans
cluster_df = pd.read_csv("assets/cluster_data.csv")
X = cluster_df[['x','y']].values
kmc_model = KMeans(
  n_clusters=2,
  init='k-means++',
  verbose=0,
  random_state=5000,
  copy_x=True,
  algorithm='lloyd'
);
kmc_model.fit(X);
y_pred_vals = kmc_model.predict(X)
y_pred_df = pd.DataFrame({'y_pred': y_pred_vals})
y_pred_df.to_csv("assets/kmc_preds.csv", index=False)
kmc_centroid_df = pd.DataFrame(kmc_model.cluster_centers_.transpose(), columns=['x','y'])
#disp(kmc_centroid_df)
kmc_centroid_df.to_csv("assets/kmc_centroids.csv", index=False)

import matplotlib.pyplot as plt
# Step size of the mesh. Decrease to increase the quality of the VQ.
h = 0.01  # point in the mesh [x_min, x_max]x[y_min, y_max].

# Plot the decision boundary. For that, we will assign a color to each
bpad = 0.05
x_min, x_max = X[:, 0].min() - bpad, X[:, 0].max() + bpad
y_min, y_max = X[:, 1].min() - bpad, X[:, 1].max() + bpad
xx, yy = np.meshgrid(np.arange(x_min, x_max, h), np.arange(y_min, y_max, h))

# Obtain labels for each point in mesh. Use last trained model.
Z = kmc_model.predict(np.c_[xx.ravel(), yy.ravel()])

# Put the result into a color plot
#custom_cmap = matplotlib.colors.LinearSegmentedColormap.from_list("", ["red","violet","blue"])
#custom_cmap = matplotlib.colors.ListedColormap(['white', 'red'])
#custom_cmap = matplotlib.colors.ListedColormap(cb_palette).reversed()
custom_cmap = matplotlib.colors.ListedColormap([cb_palette[0], cb_palette[2], cb_palette[1]])
Z = Z.reshape(xx.shape)
plt.figure(1)
plt.clf()
plt.imshow(
    Z,
    interpolation="nearest",
    extent=(xx.min(), xx.max(), yy.min(), yy.max()),
    #cmap=plt.cm.Paired,
    cmap=custom_cmap,
    aspect="auto",
    origin="lower",
)

# And plot the points
plt.plot(X[:, 0], X[:, 1], "o", markersize=6, color='white', markerfacecolor='black', alpha=0.75)
# Plot the centroids as a white X
centroids = kmc_model.cluster_centers_
plt.scatter(
    centroids[:, 0],
    centroids[:, 1],
    marker="*",
    s=250,
    linewidths=1.5,
    color='white',
    facecolor='black',
    zorder=10,
)
# Plot gaussian means as... smth else
plt.scatter(
    [0.2,0.8],
    [0.8,0.2],
    marker="*",
    s=250,
    linewidths=1.5,
    color=cb_palette[3],
    facecolor='black',
    zorder=9,
)
plt.title(
    "K-means clustering on the Gaussian mixture data"
)
plt.legend([
  'Original Data',
  'K-Means Centroids',
  'True Centroids (DGP)'
])
#plt.xlim(x_min, x_max);
#plt.ylim(y_min, y_max);
#plt.xticks(());
#plt.yticks(());
plt.show()
#
#
#
#
#
#
#
#| label: dbscan-grid
#| fig-cap: Adapted from [Scikit-learn User Guide](https://scikit-learn.org/stable/auto_examples/cluster/plot_cluster_comparison.html){target='_blank'}
import time
import warnings
from itertools import cycle, islice

import matplotlib.pyplot as plt
import numpy as np

from sklearn import cluster, datasets, mixture
from sklearn.neighbors import kneighbors_graph
from sklearn.preprocessing import StandardScaler

# ============
# Generate datasets. We choose the size big enough to see the scalability
# of the algorithms, but not too big to avoid too long running times
# ============
n_samples = 500
seed = 30
noisy_circles = datasets.make_circles(
    n_samples=n_samples, factor=0.5, noise=0.05, random_state=seed
)
noisy_moons = datasets.make_moons(n_samples=n_samples, noise=0.05, random_state=seed)
blobs = datasets.make_blobs(n_samples=n_samples, random_state=seed)
rng = np.random.RandomState(seed)
no_structure = rng.rand(n_samples, 2), None

# Anisotropicly distributed data
random_state = 170
X, y = datasets.make_blobs(n_samples=n_samples, random_state=random_state)
transformation = [[0.6, -0.6], [-0.4, 0.8]]
X_aniso = np.dot(X, transformation)
aniso = (X_aniso, y)

# blobs with varied variances
varied = datasets.make_blobs(
    n_samples=n_samples, cluster_std=[1.0, 2.5, 0.5], random_state=random_state
)

# ============
# Set up cluster parameters
# ============
plt.figure(figsize=(9 * 2 + 3, 13))
plt.subplots_adjust(
    left=0.02, right=0.98, bottom=0.001, top=0.95, wspace=0.05, hspace=0.01
)

plot_num = 1

default_base = {
    "quantile": 0.3,
    "eps": 0.3,
    "damping": 0.9,
    "preference": -200,
    "n_neighbors": 3,
    "n_clusters": 3,
    "min_samples": 7,
    "xi": 0.05,
    "min_cluster_size": 0.1,
    "allow_single_cluster": True,
    "hdbscan_min_cluster_size": 15,
    "hdbscan_min_samples": 3,
    "random_state": 42,
}

datasets = [
    (
        noisy_circles,
        {
            "damping": 0.77,
            "preference": -240,
            "quantile": 0.2,
            "n_clusters": 2,
            "min_samples": 7,
            "xi": 0.08,
        },
    ),
    (
        noisy_moons,
        {
            "damping": 0.75,
            "preference": -220,
            "n_clusters": 2,
            "min_samples": 7,
            "xi": 0.1,
        },
    ),
    # (
    #     varied,
    #     {
    #         "eps": 0.18,
    #         "n_neighbors": 2,
    #         "min_samples": 7,
    #         "xi": 0.01,
    #         "min_cluster_size": 0.2,
    #     },
    # ),
    (
        aniso,
        {
            "eps": 0.15,
            "n_neighbors": 2,
            "min_samples": 7,
            "xi": 0.1,
            "min_cluster_size": 0.2,
        },
    ),
    (blobs, {"min_samples": 7, "xi": 0.1, "min_cluster_size": 0.2}),
    (no_structure, {}),
]

for i_dataset, (dataset, algo_params) in enumerate(datasets):
    # update parameters with dataset-specific values
    params = default_base.copy()
    params.update(algo_params)

    X, y = dataset

    # normalize dataset for easier parameter selection
    X = StandardScaler().fit_transform(X)

    # estimate bandwidth for mean shift
    bandwidth = cluster.estimate_bandwidth(X, quantile=params["quantile"])

    # connectivity matrix for structured Ward
    connectivity = kneighbors_graph(
        X, n_neighbors=params["n_neighbors"], include_self=False
    )
    # make connectivity symmetric
    connectivity = 0.5 * (connectivity + connectivity.T)

    # ============
    # Create cluster objects
    # ============
    two_means = cluster.MiniBatchKMeans(
        n_clusters=params["n_clusters"],
        n_init="auto",
        random_state=params["random_state"],
    )
    # spectral = cluster.SpectralClustering(
    #     n_clusters=params["n_clusters"],
    #     eigen_solver="arpack",
    #     affinity="nearest_neighbors",
    #     random_state=params["random_state"],
    # )
    dbscan = cluster.DBSCAN(eps=params["eps"])
    average_linkage = cluster.AgglomerativeClustering(
        linkage="average",
        metric="cityblock",
        n_clusters=params["n_clusters"],
        connectivity=connectivity,
    )
    birch = cluster.Birch(n_clusters=params["n_clusters"])
    gmm = mixture.GaussianMixture(
        n_components=params["n_clusters"],
        covariance_type="full",
        random_state=params["random_state"],
    )

    clustering_algorithms = (
        ("MiniBatch\nKMeans", two_means),
        #("Affinity\nPropagation", affinity_propagation),
        #("MeanShift", ms),
        #("Spectral\nClustering", spectral),
        #("Ward", ward),
        ("Agglomerative\nClustering", average_linkage),
        ("DBSCAN", dbscan),
        #("HDBSCAN", hdbscan),
        #("OPTICS", optics),
        ("BIRCH", birch),
        ("Gaussian\nMixture", gmm),
    )

    for name, algorithm in clustering_algorithms:
        t0 = time.time()

        # catch warnings related to kneighbors_graph
        with warnings.catch_warnings():
            warnings.filterwarnings(
                "ignore",
                message="the number of connected components of the "
                + "connectivity matrix is [0-9]{1,2}"
                + " > 1. Completing it to avoid stopping the tree early.",
                category=UserWarning,
            )
            warnings.filterwarnings(
                "ignore",
                message="Graph is not fully connected, spectral embedding"
                + " may not work as expected.",
                category=UserWarning,
            )
            algorithm.fit(X)

        t1 = time.time()
        if hasattr(algorithm, "labels_"):
            y_pred = algorithm.labels_.astype(int)
        else:
            y_pred = algorithm.predict(X)

        plt.subplot(len(datasets), len(clustering_algorithms), plot_num)
        if i_dataset == 0:
            plt.title(name, size=18)

        colors = np.array(
            list(
                islice(
                    cycle(
                        [
                            "#377eb8",
                            "#ff7f00",
                            "#4daf4a",
                            "#f781bf",
                            "#a65628",
                            "#984ea3",
                            "#999999",
                            "#e41a1c",
                            "#dede00",
                        ]
                    ),
                    int(max(y_pred) + 1),
                )
            )
        )
        # add black color for outliers (if any)
        colors = np.append(colors, ["#000000"])
        plt.scatter(X[:, 0], X[:, 1], s=10, color=colors[y_pred])

        plt.xlim(-2.5, 2.5)
        plt.ylim(-2.5, 2.5)
        plt.xticks(())
        plt.yticks(())
        plt.text(
            0.99,
            0.01,
            ("%.2fs" % (t1 - t0)).lstrip("0"),
            transform=plt.gca().transAxes,
            size=15,
            horizontalalignment="right",
        )
        plot_num += 1

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
