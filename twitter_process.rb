# Problems with SSH
# TODO: Find solution to 

class TwitterProcess
	require 'twitter'
	require './twitter_app_info'
	require './twitter_file'
	require 'openssl'

	attr_accessor :client

	# HACK: disable SSH
	# TODO: Find solution for error 
	# "SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed (Twitter::Error::ClientError)"
	OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

	def initialize
		@client = Twitter::Client.new(
			consumer_key: TwitterAppInfo::CONSUMER_KEY,
			consumer_secret: TwitterAppInfo::CONSUMER_SECRET,
			oauth_token: TwitterAppInfo::OAUTH_TOKEN,
			oauth_token_secret: TwitterAppInfo::OAUTH_TOKEN_SECRET
		)
	end

	def get_tweets_with_word(keyword, count=5)
		@client.search(keyword, count: count, :result_type => "recent").results.map do |status|
		  "#{status.from_user}: #{status.text}"
		end
	end

	def create_tweet_base_with_word(word, filename, count=5)
		# TODO: Some tweets containe multiple lines. gsub('\n','') don't work on them, find solution.
		tweets = get_tweets_with_word(word, count)
		TwitterFile.write_all_to_file(filename, tweets)
	end

	def load_tweet_base(filename)
		TwitterFile.read_from_file(filename)
	end
end

def test
	twitter = TwitterProcess.new
	puts twitter.get_tweets_with_word "Hello World!", 10
end

def test_create_base
	twitter = TwitterProcess.new
	twitter.create_tweet_base_with_word('Ukraine', 'ukraine.data', 50)
end

def test_read_base
	twitter = TwitterProcess.new
	tweets = twitter.load_tweet_base('ukraine.data')
	puts tweets
end