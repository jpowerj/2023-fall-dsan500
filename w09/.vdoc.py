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
#| label: gaussian-mixture-mle
#| output: false
#| code-fold: show
import pandas as pd
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
mean_df['Estimated Cov'] = [cov_array[0],cov_array[1]]
mean_df.to_csv("assets/sklearn_mean_df.csv", index=False)
# The estimated covariance matrix
cov_array = estimator.covariances_
cov_df = pd.DataFrame({'c1': [1, cov_array[0]], 'c2': [cov_array[1], 1]})
cov_df.to_csv("assets/sklearn_cov_df.csv", index=False)
# And the predicted clusters
pred_df = pd.DataFrame({'Estimated Cluster': y_pred})
pred_df['Estimated Cluster'] = pred_df['Estimated Cluster'].apply(lambda x: 'C1' if x == 0 else 'C2')
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
