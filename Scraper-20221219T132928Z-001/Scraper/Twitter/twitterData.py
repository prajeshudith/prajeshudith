import tweepy
from tweepy import Stream
from tweepy import OAuthHandler
from tweepy.streaming import StreamListener
import datetime
import csv
import pandas as pd

# This handles Twitter authetification and the connection to Twitter Streaming API
consumerKey = ""
consumerSecret = ""
accessToken = ""
accessTokenSecret = ""

auth = OAuthHandler(consumerKey, consumerSecret)
auth.set_access_token(accessToken, accessTokenSecret)

api = tweepy.API(auth)

search_words = "cancun fc"
new_search = search_words + " -filter:retweets"
date_since = "2022-02-27"
date_until = "2022-02-28"

tweets = tweepy.Cursor(api.search,
              #place = place_id,
              q = search_words,
              lang = "es",
              since = date_since,
              until=date_until).items()
    
final_data = []

for tweet in tweets:
    u_n = api.get_user(tweet.user.screen_name)
    print("name: " + tweet.user.screen_name)
    print("description: " + u_n.description)
    print("statuses_count: " + str(u_n.statuses_count))
    print("friends_count: " + str(u_n.friends_count))
    print("followers_count: " + str(u_n.followers_count))
    
    final_data.append([tweet.user.name,tweet.user.location, tweet.created_at, tweet.text, tweet.favorite_count, tweet.retweet_count, u_n.description, u_n.statuses_count, u_n.friends_count, u_n.followers_count])

print(final_data)

tweet_text = pd.DataFrame(data=final_data, columns=["User name","Location", "Time", "Tweet", "Favorite Count", "Retweet Count", "User description", "User status count", "User friends count", "User followers count"])
tweet_text.to_csv("samp_loc_tweets_spain.csv")

