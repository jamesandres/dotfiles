#!/usr/bin/env ruby

# TODO: Read from input stream ($stdin.read) or from argument
# TODO: Ensure that the MD5 rev parser works for most common cases

require 'highline/import'

if ARGV.length < 1
  puts "Usage: git-cherry-pick-each.rb COMMITSFILE.txt"
  exit 0
end

lines = File.open(ARGV[0]).readlines

lines.each do |line|
  line.strip!

  rev = /[^a-z0-9]?([a-z0-9]{7,32})[^a-z0-9]?/.match(line)
  next if rev[1].nil?

  if agree("Are you sure you want to cherry-pick #{rev[1]}? ")
    puts `git cherry-pick #{rev[1]}`
  else
    puts "Skipment!"
  end

end
