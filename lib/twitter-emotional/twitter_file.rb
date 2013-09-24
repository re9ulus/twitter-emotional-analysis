module TwitterFile

  def TwitterFile.write_all_to_file(filename, tweets)
    File.open(filename, 'a') do |file|
      tweets.each { |tweet| file.puts(tweet) }
    end
  end

  def TwitterFile.write_to_file(filename, tweet)
    File.open(filename, 'a') { |file| file.puts(tweet) }
  end

  def TwitterFile.read_from_file(filename)
    File.open(filename).to_a
  end

end