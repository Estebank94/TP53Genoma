#!/usr/bin/env ruby

if ARGV.length != 2
  puts 'Invalid params: 1) In file path of BLAST 2) Search Pattern'
  exit
end

file=ARGV[0]
f = File.open(file, "r")
f.each_line { |line|
  hitList = []
  auxHit = ""
  if line.include? 'Hit'
      auxHit = line
  elsif line.downcase.include? ARGV[1].downcase
      puts line
      hitList << auxHit
  end
  puts hitList
}
f.close
