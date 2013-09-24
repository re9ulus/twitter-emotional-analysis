# Problems with SSH
# TODO: Find solution to 
# Refactor get/find methods to one method with symbol parameters
# Write tests

require 'twitter'
require 'openssl'
require_relative './twitter_app_info'
require_relative './twitter_file'

class TwitterProcess

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

  def clear_tweet(tweet)
    # TODO: Implement
  end

  def get_tweets_with_word(keyword, args={})
    args[:count] ||= 10
    args[:user] ||= ""
    @client.search(keyword, count: args[:count], result_type: "recent", user: args[:user]).results.map do |status|
      status.text
    end
  end

  def get_user_timeline(username, args={})
    args[:count] ||= 10
    @client.user_timeline(username, count: args[:count]).map { |status| status.text }
  end

  def create_tweet_base_with_word(word, filename, count=5)
    # TODO: Some tweets containe multiple lines. gsub('\n','') don't work on them, find solution.
    tweets = get_tweets_with_word(word, count: count)
    TwitterFile.write_all_to_file(filename, tweets)
  end
  
  def load_tweet_base(filename)
    TwitterFile.read_from_file(filename)
  end
  
end