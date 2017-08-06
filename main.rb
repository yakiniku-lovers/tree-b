require './analyzer.rb'

if ARGV.size < 1
  STDERR.puts "Usage: ruby analyze.rb <tweets.json>" 
  exit
end

a = Analyzer.new(ARGV[0]).analyze

IO.popen('./tree-c/tree_c', 'r+') {|io|
  io.puts a.to_s
  io.close_write
  p io.gets
}
