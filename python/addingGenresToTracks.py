#This script needs to add the genre column to the tracks dataset based on the artist
#If a row's artist column matches to an artist in the genres dataset, add the genres to the column
#Else make the entry NULL
#%%
import pandas as pd
import numpy as np

#don't import the expanded genres dataset because it's easier to just run the expansion funciton after the list is added to these guys
genreData = pd.read_csv("c:/code/MusicMe/data/data_w_genres.csv",
header = 0,
sep = ",",
index_col = False)

trackData = pd.read_csv("C:/code/MusicMe/data/trackData_expanded.csv")

print(genreData.columns)
print(trackData.columns) 


trackData1 = trackData.sort_values("artists")
genreData1 = genreData.sort_values("artists")

#assigns genre list to trackData under the column "genres"
#this dataframe will have to be ran through the explodingArrays function to make this useable in firebase 
for index, artist in enumerate(genreData.artists):
    trackArtist = trackData.artists
    genres = genreData.genres[index]
    artistHits = trackArtist == artist



    trackData.loc[artistHits, "genres"] = genres



trackData[trackData.genres.notnull()].to_csv("data/trackData_genres.csv")

# %%
