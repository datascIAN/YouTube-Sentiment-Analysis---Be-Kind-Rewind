--The top performing videos by viewCount:
SELECT TOP 10 title, viewcount FROM bkr_channel_data ORDER BY viewCount DESC;

--Worst performing videos by vewCount:
SELECT TOP 10 title, viewCount FROM bkr_channel_data ORDER BY viewCount ASC;

--Average view count of videos:
SELECT ROUND(AVG(viewCount),0) AS average_views FROM bkr_channel_data;

--Videos with most comments:
SELECT TOP 10 title, commentCount FROM bkr_channel_data ORDER BY commentCount DESC;

--Videos with least comments:
SELECT TOP 10 title, commentCount FROM bkr_channel_data ORDER BY commentCount ASC;

--Video comments per 1000 views:
SELECT title, ROUND((CAST(commentCount AS float)/CAST(viewCount AS float)*1000),2) as comment_view_ratio FROM bkr_channel_data ORDER BY comment_view_ratio DESC;

--Average comments on videos
SELECT ROUND(AVG(commentCount),2) AS average_comments FROM bkr_channel_data;

--Days of the week that videos are posted:
SELECT dayPublished, COUNT(title) AS videosPublished FROM bkr_channel_data GROUP BY dayPublished ORDER BY videosPublished DESC;

--Average Duration of videos in minutes:
SELECT ROUND(AVG(durationSecs)/60,2) AS average_video_duration_mins FROM bkr_channel_data;

--Videos grouped by the day of week they were published and their current view counts:
SELECT dayPublished, SUM(viewCount) AS total_views FROM bkr_channel_data GROUP BY dayPublished ORDER BY total_views DESC;

--Day of the week when comments are posted:
SELECT dayPublished, COUNT(video_id) as comments_posted FROM bkr_comments GROUP BY dayPublished ORDER BY comments_posted DESC;

--Average number of words in comments for all videos:
SELECT ROUND(AVG(orig_num_words),0) as ave_num_words_all_vids FROM bkr_comments;

--Top 10 comments with most number of words:
SELECT TOP 10 title, orig_num_words FROM bkr_comments ORDER BY orig_num_words DESC;

--Average number of words in comments for each video:
SELECT TOP 10 title, ROUND(AVG(orig_num_words),0) AS ave_num_words FROM bkr_comments GROUP BY title ORDER BY ave_num_words DESC;

--Top 10 users with most comments on videos:
SELECT TOP 10 authorDisplayName, COUNT(publishedAt) AS number_of_comments FROM bkr_comments WHERE authorDisplayName <> 'Be Kind Rewind' GROUP BY authorDisplayName ORDER BY number_of_comments DESC;

--Create a view that summarizes the number of positive, neutral and negative sentiments per video:
DROP VIEW IF EXISTS Sentiments_per_video
GO
CREATE VIEW Sentiments_per_video AS 
	SELECT title, 
	COUNT(CASE when Sentiment='Positive' THEN 1 END) AS Positive, 
	COUNT(CASE when Sentiment='Neutral' THEN 1 END) AS Neutral,
	COUNT(CASE when Sentiment='Negative' THEN 1 END) AS Negative,
	COUNT(Sentiment) AS Total_Sentiments
	FROM bkr_sentiments GROUP BY title;

GO
SELECT TOP 10 * FROM Sentiments_per_video;

--Top 10 videos with highest percentage of positive comments:
SELECT TOP 10 title, ROUND(CAST(Positive AS float)/CAST(Total_Sentiments AS float)*100,2) AS Positive_Percentage FROM Sentiments_per_video ORDER BY Positive_Percentage DESC;

--Top 10 videos with the highest percentage of neutral comments:
SELECT TOP 10 title, ROUND(CAST(Neutral AS float)/CAST(Total_Sentiments AS float)*100,2) AS Neutral_Percentage FROM Sentiments_per_video ORDER BY Neutral_Percentage DESC;

--Top 10 videos with highest percentage of negative comments:
SELECT TOP 10 title, ROUND(CAST(Negative AS float)/CAST(Total_Sentiments AS float)*100,2) AS Negative_Percentage FROM Sentiments_per_video ORDER BY Negative_Percentage DESC;

--Create a view that summarizes the number of positive, neutral and negative sentiments per commenter:
DROP VIEW IF EXISTS Sentiments_by_author
GO
CREATE VIEW Sentiments_by_author AS 
	SELECT authorDisplayName, 
	COUNT(CASE when Sentiment='Positive' THEN 1 END) AS Positive, 
	COUNT(CASE when Sentiment='Neutral' THEN 1 END) AS Neutral,
	COUNT(CASE when Sentiment='Negative' THEN 1 END) AS Negative,
	COUNT(Sentiment) AS Total_Sentiments
	FROM bkr_sentiments GROUP BY authorDisplayName;

GO
SELECT TOP 10 * FROM Sentiments_by_author;

--Top 10 users with most positive comments:
SELECT TOP 10 authorDisplayName, Positive FROM Sentiments_by_author WHERE authorDisplayName <> 'Be Kind Rewind' ORDER BY Positive DESC;

--Top 10 users with most negative comments:
SELECT TOP 10 authorDisplayName, Neutral FROM Sentiments_by_author WHERE authorDisplayName <> 'Be Kind Rewind' ORDER BY Neutral DESC;

--Top 10 users with most neutral comments:
SELECT TOP 10 authorDisplayName, Negative FROM Sentiments_by_author WHERE authorDisplayName <> 'Be Kind Rewind' ORDER BY Negative DESC;
