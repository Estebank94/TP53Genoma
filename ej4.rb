#!/usr/bin/env ruby

require 'bio'

if ARGV.length != 1
  puts 'Invalid params: 1) In file path'
  exit
end

File.open(ARGV[0], 'w') do |f|
  f.puts Bio::EMBOSS.run('water',
                          '-asequence', 'swissprot:slpi_human',
                          '-bsequence', 'swissprot:slpi_mouse')
end