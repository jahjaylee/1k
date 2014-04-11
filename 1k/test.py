r = praw.Reddit(user_agent='1kPicApp') # Note: Be sure to change the user-agent to something unique.
submissions = r.get_subreddit('pics').get_hot(limit=50)
a = []
for submission in submissions:
    # Check for all the cases where we will skip a submission:
    if "imgur.com/" not in submission.url:
        continue # skip non-imgur submissions
    if submission.score < MIN_SCORE:
        continue # skip submissions that haven't even reached 100 (thought this should be rare if we're collecting the "hot" submission)
    if len(glob.glob('reddit_%s_*' % (submission.id))) > 0:
        continue # we've already downloaded files for this reddit submission
	a.append(submission)
for url in a:
	print(url + "/n")