#!/usr/bin/python
import praw
user_agent = ("jahjaylee is trying praw")
r = praw.Reddit(user_agent=user_agent) # Note: Be sure to change the user-agent to something unique.
submissions = r.get_subreddit('pics').get_hot(limit=5)

for x in submissions:
	if ("imgur") in x.url and x.score>1000:
		print(x.url)
		print(x.score)


