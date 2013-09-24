require_relative '../twitter_process'

describe TwitterProcess do
  
  before(:all) do
    @twitter = TwitterProcess.new
    @num = 15
  end

  it 'should get tweets with word' do
    @twitter.get_tweets_with_word("Hello World!", count: @num).length.should be @num
  end

  it 'should read the base from the file' do
    @twitter.load_tweet_base('ukraine.data').length.should be > 0
  end

  it 'shold get user timeline' do
    @twitter.get_user_timeline("@twitter", count: @num).length.should be @num
  end

end