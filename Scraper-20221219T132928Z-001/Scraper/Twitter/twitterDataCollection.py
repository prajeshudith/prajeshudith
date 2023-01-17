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
date_since = "2022-01-12"
date_until = "2022-01-19"

tweets = tweepy.Cursor(api.search,
              q=search_words,
              lang="es",
              since=date_since,
              until=date_until).items()

final_data = [[tweet.user.location, tweet.created_at, tweet.text] for tweet in tweets]

tweet_text = pd.DataFrame(data=final_data, columns=["Location", "Time", "Tweet"])
tweet_text.to_csv("tweets_spanish.csv")

