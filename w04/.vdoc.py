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
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: requests-example
#| echo: true
#| code-fold: show
# Get HTML
import requests
# Perform request
response = requests.get("https://en.wikipedia.org/wiki/Data_science")
# Parse HTML
from bs4 import BeautifulSoup
soup = BeautifulSoup(response.text, 'html.parser')
all_headers = soup.find_all("h2")
section_headers = [h.find("span", {'class': 'mw-headline'}).text for h in all_headers[1:]]
section_headers
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: page-html-to-var
#| echo: false
#| code-fold: false
page_html = """<div class="all-the-data">
    <div class="data-1">
        <div class="dataval">1</div>
        <div class="dataval">2</div>
        <div class="dataval">3</div>
    </div>
    <div class="data-2">
        <ul>
            <li>4.0</li>
            <li>5.5</li>
            <li>6.7</li>
        </ul>
    </div>
</div>"""
#
#
#
#| label: bs4-parse-page
#| echo: true
#| fig-align: left
#| code-overflow: wrap
from bs4 import BeautifulSoup
soup = BeautifulSoup(page_html, 'html.parser')
ds1_elt = soup.find("div", class_='data-1')
ds1 = [e.text for e in ds1_elt.find_all("div")]
ds2_elt = soup.find("div", {'class': 'data-2'})
ds2 = [e.text for e in ds2_elt.find_all("li")]
#
#
#
#
#
#
#
#| label: bs4-output-page
#| echo: true
print(f"dataset-1: {ds1}\ndataset-2: {ds2}")
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: table-html-to-var
#| echo: false
table_html = """<table>
<thead>
  <tr>
    <th>X1</th><th>X2</th><th>X3</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>1</td><td>3</td><td>5</td>
  </tr>
  <tr>
    <td>2</td><td>4</td><td>6</td>
  </tr>
</tbody>
</table>"""
#
#
#
#| label: bs4-parse-table
#| echo: true
from bs4 import BeautifulSoup
soup = BeautifulSoup(table_html, 'html.parser')
thead = soup.find("thead")
headers = [e.text for e in thead.find_all("th")]
tbody = soup.find("tbody")
rows = tbody.find_all("tr")
data = [[e.text for e in r.find_all("td")]
            for r in rows]
#
#
#
#
#
#
#
#| label: table-parse-output
#| echo: true
print(f"headers: {headers}\ndata: {data}")
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: math-api-call
#| echo: true
#| code-fold: show
import requests
response = requests.get("https://newton.vercel.app/api/v2/factor/x^2-1")
print(response.json())
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: pygithub-noauth
#| echo: true
# import github
# g = github.Github()
# try:
#   g.get_repo("jpowerj/private-repo-test")
# except Exception as e:
#   print(e)
#
#
#
#
#
#
#
#| label: pygithub-auth
#| echo: true
# Load the access token securely
# import os
# my_access_token = os.getenv('GITHUB_TOKEN')
# import github
# # Use the access token to make an API request
# auth = github.Auth.Token(my_access_token)
# g = github.Github(auth=auth)
# g.get_user().get_repo("private-repo-test")
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
