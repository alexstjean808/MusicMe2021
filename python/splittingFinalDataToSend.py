#%%
#final data is far to large to send in one go to the database, split this sucker up
import pandas as pd 

finalData = pd.read_csv("c:/code/musicme/data/final.csv")

finalData = finalData
# print(finalData.shape)
# print(finalData.columns)
# print(finalData.year[10])
finalData = finalData[['acousticness',
       'danceability', 'duration_ms', 'energy', 'explicit', 'id',
       'instrumentalness', 'key', 'liveness', 'loudness', 'mode', 'name',
       'popularity', 'release_date', 'speechiness', 'tempo', 'valence', 'year',
       'artists', 'genres']]

# print(finalData.shape)
# print(finalData.columns)
# print(finalData.year[10])
# for column in finalData.columns:
#        error = finalData[column] == ""
#        print("{columnLoop} value counts: {values}".format(columnLoop = column, values = error.value_counts()))


finalData[:100000].to_json("data/final1.json", orient = "index")
finalData[100000:200000].to_json("data/final2.json", orient = "index")
finalData[200000:300000].to_json("data/final3.json", orient = "index")
finalData[300000:400000].to_json("data/final4.json", orient = "index")
finalData[400000:500000].to_json("data/final5.json", orient = "index")
finalData[500000:600000].to_json("data/final6.json", orient = "index")
finalData[600000:700000].to_json("data/final7.json", orient = "index")
finalData[700000:800000].to_json("data/final8.json", orient = "index")
finalData[800000:].to_json("data/final9.json", orient = "index")


