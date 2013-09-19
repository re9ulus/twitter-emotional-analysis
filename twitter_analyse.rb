module TwitterAnalyse
	require './twitter_emotional'
	require './twitter_file'
	require './twitter_process'

	@emotional = TwitterEmotional.new
	@twitter = TwitterProcess.new

	def TwitterAnalyse.positive_negative(tweets)
		rates = tweets.map { |tweet| @emotional.rate_tweet tweet }
		positive = rates.select { |rate| rate > 0 }
		negative = rates.select { |rate| rate < 0 }
		res = {
			rate_positive: ( positive.inject(:+) or 0 ),	# sum of positive tweets
			rate_negative: ( negative.inject(:+) or 0 ),	# sum of negative tweets
			count_positive: positive.length,							# count of positive tweets
			count_negative: negative.length								# count of negative tweets
		} 
	end

	def TwitterAnalyse.analyse_file(filename)
		tweets = TwitterFile.read_from_file(filename)
		positive_negative(tweets)
	end

	def TwitterAnalyse.tweets_with_word(word, count=5)
		tweets = @twitter.get_tweets_with_word(word, count)
		positive_negative(tweets)
	end

	def TwitterAnalyse.tweets_with_geocode()
		# TODO: Implement
	end

	def TwitterAnalyse.user_tweets()
		# TODO: Implement
	end
end

def test_analyse_file
	TwitterAnalyse.analyse_file "ukraine.data"
end

def test_tweets_with_word
	TwitterAnalyse.tweets_with_word("Ok", 100)
end