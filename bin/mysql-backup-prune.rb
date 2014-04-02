# By James Andres for Meedan
# Authored April 6th, 2012
#
# This script traverses a directory full of backups and attempts to prune old
# backups in an intelligent way.
#
# Pruning approach
#  - Always keep at least one backup per month of each database
#  - Keep daily backups for "fairly recent" events, eg: daily backups
#    going back 30 days
#  - Don't ever prune any backups that are very recent, eg: last week
#
require 'date'

# Path where the MySQL backups are stored
Backups = "/Users/james/Desktop/mysql-backup-cleanup/backup"

# A regular expression that splits a backup filename into the named groups
# 'Database' and 'Date'.  eg: "yallah_qfi.2012-12-31_23:59:59.gz"
FormatRegEx = /^(?<Database>[^\.]+).(?<Date>[^\.]+)\.gz$/
FileGlob = "*.gz"

# Settings and options
opts = {
  :days_to_keep_daily  => 30,
  :days_to_keep_hourly => 7
}


# Sanity tests
if !File.directory?(Backups)
  puts "Not a directory! #{Backups}"
  exit 1
end
if FormatRegEx.nil?
  puts "Invalid FormatRegEx!"
  exit 2
end


# The date map
map     = {}
# Current date and helpers
d       = Date.today
d_year  = d.year
d_month = d.month

# Count out all years from 2000 to this year
(2000 .. (d.year)).each do |year|
  map[year] = {}
  (1..12).each do |month|
    map[year][month] = {}
  end
end

# Count back 30 days from today
(d - opts[:days_to_keep_daily]).upto(d).each do |date|
  map[date.year][date.month][date.day] = {}
end

# Count back 7 days from today
(d - opts[:days_to_keep_hourly]).upto(d).each do |date|
  map[date.year][date.month][date.day][:all_hours] = true;
end

# DEBUG
# require 'yaml'
# puts map.to_yaml

# Deletes 'path' if another copy of that same database exists in this map_subtree
def delete_unless_first_of_type(map_subtree, database, path)
  map_subtree[:databases] = map_subtree[:databases] || {}

  if map_subtree[:databases].has_key?(database)
    puts "Pruning redundant backup '#{File.basename(path)}' .."
    File.unlink(path)
  end

  map_subtree[:databases][database] = true
end

# Loops through all files in the Backups directory and prunes as necessary
Dir.glob(File.join(Backups, FileGlob)) do |path|
  filename = File.basename(path).strip

  match = FormatRegEx.match(filename)
  next if match.nil? || match['Database'].nil? || match['Date'].nil?

  database = match['Database'].to_s
  date     = DateTime.parse(match['Date'])

  if !map[date.year].nil?
    if !map[date.year][date.month].nil?
      if !map[date.year][date.month][date.day].nil?
        if map[date.year][date.month][date.day][:all_hours]
          # Skip this entry entirely it is supposed to have maximum granularity
          next
        else
          delete_unless_first_of_type map[date.year][date.month][date.day], database, path
        end
      else
        delete_unless_first_of_type map[date.year][date.month], database, path
      end
    else
      delete_unless_first_of_type map[date.year], database, path
    end
  end
end
