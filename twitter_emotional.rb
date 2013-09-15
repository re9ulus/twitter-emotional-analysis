class TwitterEmotional
	
	def initialize
		@word_pattern = /\b(\w+)\b/
	end

	def word_emotion(word)
		1
	end

	def words_from_tweet(tweet)	
		tweet.scan(@word_pattern)
	end

	def tweet_emotion(tweet)
		words = words_from_tweet tweet
		res = 0
		words.each { |word| res += word_emotion word }
		res
	end

end