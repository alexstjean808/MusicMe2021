#%%
import pandas as pd
import numpy as np
import ast
import ipdb
import json

#the goal of this script is to help fix the issues with arrays in Firebase
#Issue: Artists and genres are stored in arrays in the data, but Firebase doesn't support arrays
# Solution:
# * Explode the arrays in the cells as new rows with each value in the array as a single value in the new row
# * Combine Genres and Artists together


#import data
genreData = pd.read_csv("c:/code/MusicMe/data/data_w_genres.csv",
header = 0,
sep = ",",
index_col = False)

trackData = pd.read_csv("C:/code/MusicMe/data/data.csv")
trackData = trackData
genreData = genreData

#added after the first two but the same function will be done. 
trackData_genres = pd.read_csv("C:/code/MusicMe/data/trackData_genres.csv")
print(trackData_genres.columns)

#convert the data from having '[]' to be []. json.dumps is not my favorite. I was not right in its use
genreData["genres"] = genreData["genres"].apply(ast.literal_eval)

trackData["artists"] = trackData["artists"].apply(ast.literal_eval)

trackData_genres["genres"] = trackData_genres["genres"].apply(ast.literal_eval)

#this function opens dataframe columns that have embedded lists and makes each value in the list assigned to the new_column as one value
#substantially expands the quantity of rows in a dataframe though 
def expand_list(df, list_column, new_column): #be careful that the values in the columns are actually lists not strings that look like lists
    lens_of_lists = df[list_column].apply(len)
    origin_rows = range(df.shape[0])
    destination_rows = np.repeat(origin_rows, lens_of_lists)
    non_list_cols = (
      [idx for idx, col in enumerate(df.columns)
       if col != list_column]
    )
    expanded_df = df.iloc[destination_rows, non_list_cols].copy()
    expanded_df[new_column] = (
      [item for items in df[list_column] for item in items]
      )
    expanded_df.reset_index(inplace=True, drop=True)
    return expanded_df

#usage
genreData_expanded = expand_list(genreData,"genres", "genre")
trackData_expanded = expand_list(trackData, "artists", "artists")
trackData_genres_expanded = expand_list(trackData_genres, "genres", "genres")

#verify that genres and artists are being printed, NOT letters
print(genreData_expanded["genre"])
print(trackData_expanded["artists"])
#save data to local directory
#genreData_expanded.to_csv("c:/code/musicme/data/genreData_expanded.csv")
#trackData_expanded.to_csv("c:/code/musicme/data/trackData_expanded.csv")
trackData_genres_expanded.to_csv("c:/code/musicme/data/trackData_genres_expanded.csv")

print(trackData_genres_expanded.columns)
