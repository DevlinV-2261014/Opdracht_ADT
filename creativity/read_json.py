import pandas as pd

# This script simply reads the json file to see if it works
def main():
    df = pd.read_json('IMDB.json')
    print(df.head())
if __name__ == "__main__":
    main()