require_relative './twitter_emotional'
require_relative './twitter_file'
require_relative './twitter_process'

module TwitterAnalyse

  @emotional = TwitterEmotional.new
  @twitter = TwitterProcess.new

  def TwitterAnalyse.positive_negative(tweets)
    rates = tweets.map { |tweet| @emotional.rate_tweet tweet }
    positive = rates.select { |rate| rate > 0 }
    negative = rates.select { |rate| rate < 0 }
    res = {
      rate_positive: ( positive.inject(:+) or 0 ),  # sum of positive tweets
      rate_negative: ( negative.inject(:+) or 0 ),  # sum of negative tweets
      count_positive: positive.length,              # count of positive tweets
      count_negative: negative.length               # count of negative tweets
    } 
  end

  def TwitterAnalyse.analyse_file(filename)
    tweets = TwitterFile.read_from_file(filename)
    positive_negative(tweets)
  end

  def TwitterAnalyse.tweets_with_word(word, count=10)
    tweets = @twitter.get_tweets_with_word(word, count: count)
    positive_negative(tweets)
  end

  def TwitterAnalyse.tweets_with_geocode()
    # TODO: Implement
  end

  def TwitterAnalyse.user_timeline(username, count=10)
    tweets = @twitter.get_user_timeline(username, count: count)
    positive_negative(tweets)
  end

  def TwitterAnalyse.compare_two_words(word1, word2, count=10)
    # TODO: Add analytics
    "#{word1}\t#{tweets_with_word(word1, count)}\n#{word2}\t#{tweets_with_word(word2, count)}"
  end

  def TwitterAnalyse.analyse_all(words, count=10)
    words.map { |word| tweets_with_word(word, count) }
  end
end