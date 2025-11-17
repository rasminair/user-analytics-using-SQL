-- Problem 1 Part A - # Oldest 5 users
SELECT id, username, created_at
FROM users
ORDER BY created_at ASC
LIMIT 5;

-- Problem 2 # Passive users / inactive users whose photo.id is null(not posted evan a single photo in instagram)
SELECT users.id, users.username
FROM users
LEFT JOIN photos ON photos.user_id = users.id
WHERE photos.id IS NULL;

-- Problem 3 # Contest Winner Declaration. Contest - Most number of likes on a single photo posted by a user
SELECT photos.id, photos.image_url, photos.user_id, COUNT(likes.user_id) AS like_count
FROM photos
JOIN likes ON photos.id = likes.photo_id
GROUP BY photos.id
ORDER BY like_count DESC
LIMIT 1;

-- Problem 4 # Hashtag Research/Trending Tag. Looking for the most popular 5 tags for the business, How many photos are using the same tag. 
SELECT tags.tag_name, COUNT(photo_tags.photo_id) AS usage_count
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY usage_count DESC
LIMIT 5;

-- Problem 5 - Best day of the week to launch an ads -- Most active instagram day ('Dayname 'created_at' shows the signed up day')
SELECT DAYNAME(created_at) AS day_of_week, COUNT(*) AS user_count
FROM users
GROUP BY day_of_week
ORDER BY user_count DESC
LIMIT 1;

-- Problem 6 # Part B - Investor Metrics. Average number of posts (photos) per user on Instagram.
SELECT AVG(photo_count) AS avg_posts_per_user
FROM(
	SELECT users.id, COUNT(photos.id) AS photo_count
	FROM users
	LEFT JOIN photos ON users.id = photos.user_id
	GROUP BY users.id
) AS photo_count;

-- problem 6 # Simplified way to take the average
SELECT(
(SELECT count(*) FROM Photos) / (SELECT COUNT(*) FROM users)
) AS average_posts_per_user;

-- Problem 7 # Bots (who likes every single photo in Instagram) & Fake Accounts who cause Instagram crowded
-- (Fake Account Behaviour - Find the total number of photos and  how many likes each user is using to find potential Bots, who likes every single photo on the site, not typically possible by a normal user.)
SELECT u.id, u.username
FROM users u
WHERE (SELECT COUNT(*) FROM photos) = (SELECT COUNT(*) FROM likes l where l.user_id = u.id);




