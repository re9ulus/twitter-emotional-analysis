# Problems with SSH
# TODO: Find solution to 

class TwitterProcess
	require 'twitter'
	require './twitter_app_info'
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
		@client.user("Helen_Techer")
	end

	def get_tweets_with_word(keyword, count=5)
		@client.search(keyword, count: count, :result_type => "recent").results.map do |status|
		  "#{status.from_user}: #{status.text}"
		end
	end
end

def test
	twitter = TwitterProcess.new
	puts twitter.get_tweets_with_word "Hello World!", 10
end