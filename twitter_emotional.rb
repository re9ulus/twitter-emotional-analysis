class TwitterEmotional

	RATED_WORDS_FILE_PATH = 'AFFIN-111.txt'

	def initialize()
		@rated_words = {}
		File.open(RATED_WORDS_FILE_PATH).each do |line|
			word, rate = line.split
			# HACK: removes expressions from 2 or more words.
			# TODO: process multiple words
		  rate = Integer(rate) rescue nil 
			@rated_words[word.strip] = Integer(rate) if rate 
		end
	end

	def rate_word(word)
		if @rated_words.include? word
			@rated_words[word]
		else
			puts word + '+'
			0
		end
	end

	def words_from_tweet(tweet)	
		tweet.downcase.split(/\W+/)
	end

	def rate_tweet(tweet)
		rates = words_from_tweet(tweet).map { |word| rate_word(word) }
		rates.inject(:+)
	end

end