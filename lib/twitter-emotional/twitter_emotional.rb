class TwitterEmotional

  def initialize(rated_words_path = './AFFIN-111.txt')
    @rated_words = {}
    File.open(rated_words_path).each do |line|
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
      0
    end
  end

  def words_from_tweet(tweet) 
    tweet.downcase.split(/\W+/)
  end

  def rate_tweet(tweet)
    rates = words_from_tweet(tweet).map { |word| rate_word(word) }
    # HACK: Sometimes on empty tweets rates return nil, and rates.inject(:+) return nil instead of number
    # TODO: Fix
    rates.inject(:+) || 0
  end

end