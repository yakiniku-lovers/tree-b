require './analyzer.rb'

if ARGV.size < 1
  STDERR.puts "Usage: ruby analyze.rb <tweets.json>" 
  exit
end

a = Analyzer.new(ARGV[0]).analyze
a.dump
