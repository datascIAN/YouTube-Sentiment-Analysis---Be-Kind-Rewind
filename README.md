# YouTube Sentiment Analysis - Be Kind Rewind

## Description
**[Be Kind Rewind](https://www.youtube.com/channel/UCNiolZNLiJplmCCzqk9-czQ)** is a YouTube channel mainly about past best actress winners, women in film, and film and Hollywood history. The videos delve into the career of these accomplished women and the circumstances that lead to their win. The videos are well-researched and very insightful. I love history, I love film, and I love women in film so I truly enjoy every video from this channel. And so I wanted to see what other people thought about this channel and its videos.  

In this project, I apply natural language processing (NLP) to determine the general sentiments on this channel. The results of this project will provide the creator behind this YouTube channel a good idea of how viewers perceive the content produced.

## Objectives
The goals of this project are:
- Use the YouTube API to collect the data for this project  
- Analyze the performance of the videos of the channel  
- Determine the polarity of sentiments in the video comments using NLP  
- Get the most common words used in comments  
- Determine the overall sentiment for the channel  

## Tools
- Python - used to extract the data, clean and preprocess the data, get the sentiments from the comments, and analyze the data. The libraries used were:  
  - NumPy  
  - Pandas  
  - Google API client  
  - Matplotlib  
  - Seaborn  
  - WordCloud  
  - Demoji  
  - NLTK  
  - TextBlob  
- SQL Server – store the data and retrieve information for analysis  
- YouTube API – source of the data  

## Steps
1. Download channel, video, and comments data from YouTube using the YouTube API
2. Clean and preprocess the data
3. Perform exploratory data analysis (EDA) on the data
4. Analyze the sentiment of all the comments on the videos and the channel as a whole
5. Conclusion   

## The Data
The data was scraped using Google Youtube Data API version 3.0. There are two datasets: one for the details for each of the 67 videos on the channel and one for the comments posted for all of the videos on the channel. The first dataset was used to analyze the overall performance of the channel. The second dataset was used to get the sentiments from viewers.

## Data Cleaning and Preprocessing
After importing the libraries and extracting the data of the channel from YouTube, we prepared the data for analysis by doing the following:
- Check the data types of each column and number of non-null values
- Convert numerical columns to numeric
- Remove the column 'favouriteCount' since this column has no data
- Convert 'duration' column to seconds
- Add a column that indicates the day of the week the videos and comments were published based on the column 'publishedAt'
- Add column 'tagCount'
- Remove emojis	
- Insert a column to indicate the language the comment was written in and remove comments in languages other than English
- Remove stop words and special characters, lemmatize words
- Get the number of words in each comment

## EDA
The exploratory data analysis was performed using SQL to retrieve information from the datasets. Python was also used for the analysis to visualize the analysis. Some of the notable insights gained from this analysis are as follows:

#### Top performing videos by viewCount
<p align="center">
  <img width="60%" height="60%" src="/images/eda1t.jpg" />
  <img width="100%" height="100%" src="/images/eda1g.jpg" />
</p>
The most viewed videos are those that discuss movies and personalities who are familiar to today’s audiences. The channel goes over the story of past best actress winners all the way from the infancy of the Oscars. Average viewers may not be able to easily recognize and relate to the subject of some of the videos especially those from the Golden Age of Hollywood. The top 4 most viewed videos cover movies that were recently made (or remade) or actresses that are currently active who won their Oscar within the last 2 decades. The top 5 and 6 most watched video also has this characteristic in a way. They delve into the story  of 2 actresses from the Golden Age of Hollywood who were the subjects of a recent popular TV series. 

#### Average view count of videos
<p align="center">
  <img width="60%" height="60%" src="/images/eda3.jpg" />
</p>
The average views of channel per video is 352,354.

#### Videos with the most comments
<p align="center">
  <img width="60%" height="60%" src="/images/eda5t.jpg" />
  <img width="100%" height="100%" src="/images/eda5g.jpg" />
</p>
Videos with the most comments are also those that cover actresses and movies that are more recent as they would be more familiar to today’s viewers.

#### Average number of comments
<p align="center">
  <img width="60%" height="60%" src="/images/eda7.jpg" />
</p>
The average number of comments on the channel’s videos is 1,246.

#### Video comments per 1000 views
<p align="center">
  <img width="60%" height="60%" src="/images/eda8t.jpg" />
  <img width="100%" height="100%" src="/images/eda8g.jpg" />
</p>
Video comments are correlated to views since the more views a video has, the more chance the video will have of getting comments. Thus, to be able to better compare the comment count of videos, we need to consider them in the context of their view counts. The comment count was divided by the total views of each video and then multiplied by 1000. Using this ratio, we can see that the most commented video per 1000 views is the channel’s Q&A video. Perhaps the reason behind this is that this video is a way for the creator of the channel to engage with the channel’s audience and this, in turn, resulted to more comments.

#### Average number of words in comments for all videos
<p align="center">
  <img width="60%" height="60%" src="/images/eda15.jpg" />
</p>
Comments have an average length of 33 words. 

#### Correlation of viewCount, likeCount, commentCount, duration, tagCount, and comment_view_ratio
<p align="center">
  <img width="100%" height="100%" src="/images/eda19.jpg" />
</p>
There is a high correlation between viewCount, likeCount, and commentCount. The more a video is viewed, the higher the chance of it getting likes and comments from the viewers.

#### Scatterplot  of viewCount against commentCount, likeCount, tagCount, and durationSecs
<p align="center">
  <img width="100%" height="100%" src="/images/eda20.jpg" />
</p>
As seen in the correlation matrix, there is a positive correlation between commentCount and viewCount as well as likeCount and viewCount. Videos with higher viewCounts have higher like counts and comment counts. There is no distinguishable relationship between durationSecs and viewCount as well as tagCount and viewCount. 

## Sentiment Analysis
TextBlob was used to analyze each comment and determine their subjectivity and polarity. **Polarity** defines orientation of a statement whether it expresses a positive, neutral, or negative sentiment. It expressed as a score from -1 to +1 where -1 means a negative statement and +1 means a positive statement. **Subjectivity** measures the amount of personal opinion or factual information contained in a text. It’s value is from 0 to 1 with 1 meaning it expresses personal opinion. 

Based on the polarity score, each comment was tagged as ‘Positive’ if the score > 0, ‘Neutral’ if the score = 0, and ‘Negative’ if the score < 0. 

#### Overall Sentiment
<p align="center">
  <img width="60%" height="60%" src="/images/number-of-sentiment.jpg" />
  <img width="100%" height="100%" src="/images/number-of-sentiment-g.jpg" />
</p>
The channel has more positive comments than neutral or negative comments. With 63.53% of the comments being positive, viewers generally like the content available on the channel Be Kind Rewind.

#### Average sentiment on videos
<p align="center">
  <img width="60%" height="60%" src="/images/avg-sentiment.jpg" />
</p>
The videos have an average of 64.88% of their comments being positive. Negative comments are only 11.63% on average for the videos.

#### Top 10 videos with the highest percentage of positive comments
<p align="center">
  <img width="60%" height="60%" src="/images/top-vids-pos-com-t.jpg" />
  <img width="100%" height="100%" src="/images/top-vids-pos-com-g.jpg" />
</p>

#### Top 10 videos with the highest percentage of negative comments
<p align="center">
  <img width="60%" height="60%" src="/images/top-vids-neg-com-t.jpg" />
  <img width="100%" height="100%" src="/images/top-vids-neg-com-g.jpg" />
</p>

#### Top 10 users with most positive comments
<p align="center">
  <img width="60%" height="60%" src="/images/top-users-pos-com.jpg" />
</p>

#### Word Cloud of Positive Video Comments
<p align="center">
  <img width="60%" height="60%" src="/images/word-cloud-positive.jpg" />
</p>

## Conclusion
Based on the sentiments of comments on the channel’s videos, we can conclude that the channel is generally well received by viewers.  Majority of the comments (63.53%) are positive. The videos have an average of 64.88% of their comments being positive. Some of the most used words in the positive comments are **love, great, think, time, good,** and **woman**. 
