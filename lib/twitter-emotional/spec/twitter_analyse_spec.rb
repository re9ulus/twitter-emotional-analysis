require_relative '../twitter_analyse'

describe TwitterAnalyse do

  it 'should analyse data from file' do
    TwitterAnalyse.analyse_file("ukraine.data").should_not be_nil
  end

  it 'should analyse tweets with word' do
    TwitterAnalyse.tweets_with_word("Ok", 10).should_not be_nil
  end

  it 'should analyse user timeline' do
    TwitterAnalyse.user_timeline("@twitter", 10).should_not be_nil
  end
  
  it 'should compare two words' do
    TwitterAnalyse.compare_two_words("Hello", "World", 10).should_not be_nil
  end

  it 'should analyse all words' do
    TwitterAnalyse.analyse_all(["This","Three","Words"]).length.should be 3
  end
  
end