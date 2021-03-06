#!/usr/bin/env ruby

require 'set'

require 'pry'

DICT = Set.new(File.read('/usr/share/dict/words').split("\n").map(&:downcase))

forest = <<FOREST.chomp.split("\n").map {|i| i.split(//) }
ATLAKCAJL
LOENCALUE
LJOIKLESS
IAPSRESEA
GMAPETOAE
AERLETOGW
TLDNRAMRO
OEVEASAEL
RAEBTEXOF
FOREST

def forest.words(x, y, n=2)
  dirs = (1..n).map do |i|
    [[0,i], [0,-i], [i,0], [-i,0],
     [i,i], [i,-i], [-i,i], [-i,-i]]
  end
  dirs = (0..7).map {|i| [[0,0]].concat(dirs.map {|x| x[i] }) }

  words = dirs.map do |dir|
    word = dir.map do |xx,yy|
      next unless (0..8).cover?(x+xx) && (0..8).cover?(y+yy)
      self[x+xx][y+yy]
    end.join
  end.select {|word| (word.size == n+1) && DICT.include?(word.downcase) }
end

all = []
forest.size.times do |x|
  forest[x].size.times do |y|
    words = forest.words(x,y)
    next if words.empty?
    puts "(#{x},#{y}): #{words.join(', ')}"
    all.concat(words)
  end
end
# puts all.sort

# def all.ring(word)
#   word.size.times do |i|
#     r = word.dup
#     r[i] = '.'
#     poss = self.grep(Regexp.new(r)).reject {|w| w == word }
#     puts poss unless poss.empty?
#   end
# end

# binding.pry
#
# to jam eleven letters in cal use a grease
