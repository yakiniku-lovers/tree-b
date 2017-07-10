require 'json'
require 'pp'
require 'natto'

class Analyzer
  def initialize path
    @raw_json = File.read(path)
    @tweets = JSON.parse(@raw_json, :symbolize_names => true) rescue {}

    @genre_template = {
      aware: 0,
      haji: 0,
      ikari: 0,
      iya: 0,
      kowa: 0,
      odoroki: 0,
      suki: 0,
      takaburi: 0,
      yasu: 0,
      yorokobi: 0,
    }
    
    @result = []
  end
  
  def analyze
    @tweets.each do |t|
      genre = @genre_template.dup
      
      result_raw = `python3 query.py '#{t[:text]}'`
      
      obj = JSON.parse(result_raw, :symbolize_names => true)
      pp obj
      if obj[:emotion]
        obj[:emotion].each_pair do |k, v|
          genre[k] += v.map{|word| t[:text].scan(/#{word}/).size}.sum
        end
      end
      
      @result << genre
    end
    
    self
  end
  
  def dump
    puts "#{@result.size} #{@genre_template.keys.size}"
    puts @genre_template.keys.map(&:to_s).join(' ')
    @result.each do |r|
      puts r.values.join(' ')
    end
  end
end
