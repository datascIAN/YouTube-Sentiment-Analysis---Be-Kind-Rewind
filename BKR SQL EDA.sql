USE [BKR SA];

--1. Top performing videos by viewCount:
SELECT TOP 10 title, viewcount FROM bkr_channel_data ORDER BY viewCount DESC;

--2. Worst performing videos by vewCount:
SELECT TOP 10 title, viewCount FROM bkr_channel_data ORDER BY viewCount ASC;

--3. Average view count of videos:
SELECT ROUND(AVG(viewCount),0) AS average_views FROM bkr_channel_data;

--4. Distribution of viewCount (visualization through Python)

--5. Videos with most comments:
SELECT TOP 10 title, commentCount FROM bkr_channel_data ORDER BY commentCount DESC;

--6. Videos with least comments:
SELECT TOP 10 title, commentCount FROM bkr_channel_data ORDER BY commentCount ASC;

--7. Average number of comments on videos
SELECT ROUND(AVG(commentCount),2) AS average_comments FROM bkr_channel_data;

--8. Video comments per 1000 views:
SELECT TOP 10 title, ROUND((CAST(commentCount AS float)/CAST(viewCount AS float)*1000),2) as comment_per_1k_view FROM bkr_channel_data ORDER BY comment_per_1k_view DESC;

--9. Distribution of commentCount (visualization through Python)

--10. Videos with most likes:
SELECT TOP 10 title, likeCount FROM bkr_channel_data ORDER BY likeCount DESC;

--11. Days of the week that videos are posted:
SELECT dayPublished, COUNT(title) AS videosPublished FROM bkr_channel_data GROUP BY dayPublished ORDER BY videosPublished DESC;

--12. Day of week videos were published and their current view counts:
SELECT dayPublished, SUM(viewCount) AS total_views FROM bkr_channel_data GROUP BY dayPublished ORDER BY total_views DESC;

--13. Average duration of videos in minutes:
SELECT ROUND(AVG(durationSecs)/60,2) AS average_video_duration_mins FROM bkr_channel_data;

--14. Day of the week when comments are posted:
SELECT dayPublished, COUNT(video_id) as comments_posted FROM bkr_comments GROUP BY dayPublished ORDER BY comments_posted DESC;

--15. Average number of words in comments for all videos:
SELECT ROUND(AVG(orig_num_words),0) as ave_num_words_all_vids FROM bkr_comments;

--16. Top 10 videos with the highest average number of words in comments:
SELECT TOP 10 title, ROUND(AVG(orig_num_words),0) AS ave_num_words FROM bkr_comments GROUP BY title ORDER BY ave_num_words DESC;

--17. Videos with the top 10 comments with the most number of words:
SELECT TOP 10 title, orig_num_words FROM bkr_comments ORDER BY orig_num_words DESC;

--18. Top 10 viewers with most comments on videos:
SELECT TOP 10 authorDisplayName, COUNT(publishedAt) AS number_of_comments FROM bkr_comments WHERE authorDisplayName <> 'Be Kind Rewind' GROUP BY authorDisplayName ORDER BY number_of_comments DESC;

--SENTIMENT ANALYSIS

--Number of Positive, Neutral, and Negative comments:
SELECT Sentiment, COUNT(Sentiment) AS number_of_sentiment FROM bkr_sentiments GROUP BY Sentiment;

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

--Overall positive sentiment percentage for the channel:
SELECT ROUND(CAST(SUM(Positive) AS float)/CAST(SUM(Total_Sentiments) AS float)*100,2) AS Overall_Positive_Sentiment FROM Sentiments_per_video; 

--Overall neutral sentiment percentage for the channel:
SELECT ROUND(CAST(SUM(Neutral) AS float)/CAST(SUM(Total_Sentiments) AS float)*100,2) AS Overall_Neutral_Sentiment FROM Sentiments_per_video; 

--Overall negative sentiment percentage for the channel:
SELECT ROUND(CAST(SUM(Negative) AS float)/CAST(SUM(Total_Sentiments) AS float)*100,2) AS Overall_Negative_Sentiment FROM Sentiments_per_video; 

--Top 10 videos with highest percentage of positive comments:
SELECT TOP 10 title, ROUND(CAST(Positive AS float)/CAST(Total_Sentiments AS float)*100,2) AS Positive_Percentage FROM Sentiments_per_video ORDER BY Positive_Percentage DESC;

--Top 10 videos with the highest percentage of neutral comments:
SELECT TOP 10 title, ROUND(CAST(Neutral AS float)/CAST(Total_Sentiments AS float)*100,2) AS Neutral_Percentage FROM Sentiments_per_video ORDER BY Neutral_Percentage DESC;

--Top 10 videos with highest percentage of negative comments:
SELECT TOP 10 title, ROUND(CAST(Negative AS float)/CAST(Total_Sentiments AS float)*100,2) AS Negative_Percentage FROM Sentiments_per_video ORDER BY Negative_Percentage DESC;

--Averge Positive rating per video
SELECT  ROUND(AVG(ROUND(CAST(Positive AS float)/CAST(Total_Sentiments AS float)*100,2)),2) AS avg_positive_percentage FROM Sentiments_per_video;

--Averge Neutral rating per video
SELECT  ROUND(AVG(ROUND(CAST(Neutral AS float)/CAST(Total_Sentiments AS float)*100,2)),2) AS avg_neutral_percentage FROM Sentiments_per_video;

--Averge Negative rating per video
SELECT  ROUND(AVG(ROUND(CAST(Negative AS float)/CAST(Total_Sentiments AS float)*100,2)),2) AS avg_negative_percentage FROM Sentiments_per_video;


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
