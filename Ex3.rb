#!/usr/bin/env ruby
require 'bio'


if ARGV.length != 4
  puts 'Invalid params: 1) In file path - 2) Out file path - 3) Pattern - 4) Type ( --prot or --nuc )'
  exit
end

pattern = ARGV[2].upcase
type = ARGV[3]

if !(type.eql?('--prot') || type.eql?('--nuc'))
  puts 'Possible types are --prot and --nuc'
  exit
end

Bio::NCBI.default_email = "@"

File.open(ARGV[1], 'w') do |f|
  f.puts "Pattern: #{pattern}"
  Bio::Blast.reports(File.new(ARGV[0])) do |report|
    report.each do |hit|
      if hit.definition.upcase.index(pattern)
        f.puts '------------------------------------------------'
        f.puts "- Definition: #{hit.definition}"
        f.puts "- Accession: #{hit.accession}"
        f.write "- Fasta sequence: "
        if type.eql?('--prot')
          f.puts Bio::NCBI::REST::EFetch.protein(hit.accession, "fasta")
        elsif type.eql?('--nuc')
          f.puts Bio::NCBI::REST::EFetch.nucleotide(hit.accession, "fasta")
        end
      end
    end
  end
end