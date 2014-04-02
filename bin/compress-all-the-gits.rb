#!/usr/bin/env ruby

def shellescape(str)
  # An empty argument will be skipped, so return empty quotes.
  return "''" if str.empty?

  str = str.dup

  # Process as a single byte sequence because not all shell
  # implementations are multibyte aware.
  str.gsub!(/([^A-Za-z0-9_\-.,:\/@\n])/n, "\\\\\\1")

  # A LF cannot be escaped with a backslash because a backslash + LF
  # combo is regarded as line continuation and simply ignored.
  str.gsub!(/\n/, "'\n'")

  return str
end

`find . -type d -name '.git'`.split("\n").each do |path|
  path = path.strip.chomp('.git')
  puts "## " + path

  puts `cd '#{shellescape(path)}'; rm -rf .git/refs/original/ && git reflog expire --expire=now --all && git gc --aggressive --prune=now`
end

