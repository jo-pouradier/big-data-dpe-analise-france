import requests
import pandas as pd
import os
import multiprocessing

# Define the file name
file_name = "data.csv"

# Load the columns to select from a CSV file
select_columns_df = pd.read_csv('./columns_less_than_50_missing.csv')
print(select_columns_df.head())
select_columns = select_columns_df.iloc[:, 0].tolist()
select_columns_str = ",".join(select_columns)


# Define the base URL
base_url = "https://data.ademe.fr/data-fair/api/v1/datasets/dpe-v2-logements-existants/lines"
params = {
    "size": 1000,
    # "select": select_columns_str,
    "format": "csv",
    "geo_distance" : "45.4200:4.4800:5000000",
}



def download_file(url,page=1):
    response = requests.get(url, params=params)
    file_name = f"data_page_{page}.csv"
    print(response.content)
    with open(file_name, 'wb') as file:
        file.write(response.content)
    print(response.headers)

    next_url = response.headers["Link"]
    next_url = next_url[1:].split(">")[0]
    print(next_url)
    
    print(f"File downloaded and saved as {file_name}")

# Create a pool of workers and download files in parallel
if __name__ == "__main__":
    os.makedirs("data", exist_ok=True)
    os.chdir("data")
    download_file(base_url)


