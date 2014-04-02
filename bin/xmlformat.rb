#!/usr/bin/ruby

require 'fileutils'

if ARGV[0].nil?
	puts "Usage: xmlformat.rb FILE"
	exit 0
end

file = ARGV[0]

indent = 0
first = true

f = open(file)

until f.eof?
	byte = f.read(1)

	# Match tag opening
	if byte == '<'
		next_byte = f.read(1)

		print "\n" if !first
		indent.times { print "\t" }

		if next_byte == '/'
			indent -= 1
			print "\n\nERROR (-1, #{byte}, #{next_byte})" if indent <= 0
		else
			indent += 1
		end

		print byte << next_byte
	else
		print byte
	end

	first = false
end
