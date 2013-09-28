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

  def TwitterFile.write_stats_to_file(filename, stats)
    # TODO: Test
    File.open(filename, 'a') do |file|
      stats.each ( |stat| file.puts(stat) )
    end
  end

  def TwitterFile.read_stats_from_file(filename)
    # TODO: Test
    stats = File.open(filename).to_a
    stats.map { |stat| stat.split.map { |num| Integer(num) } }
  end

end