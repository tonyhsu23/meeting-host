#!/usr/bin/env ruby
require 'gemoji'

def create_team_file
  File.open('team', 'w') do |file|
    print 'Enter team leader name: '
    file.write(gets.chomp.gsub(/\s+/, '') + ',')
    print 'Enter team member names split with comma: '
    file.write(gets.chomp.gsub(/\s+/, '') + "\n")
    file.close
  end
end

def import_team_members
  members = IO.foreach('team').to_a[0].split(',')
  @team_leader  = members.first
  @team_members = members[1..-1]
end

def input_convert(answer)
  case answer
  when /(yes|y)/i then true
  when /(no|n)/i  then false
  else;                false
  end
end

def find_host(leader_exist)
  @team_members << @team_leader if leader_exist
  @team_members.sample
end

def gemoji_installed?
  `gem list gemoji -i`
end

def find_emoji_of(name)
  Emoji.find_by_alias(name).raw
end

if gemoji_installed?
  create_team_file unless File.file?('team')
  import_team_members
  print "Is #{@team_leader} here #{find_emoji_of('thinking')}  [y/n] "
  puts "Today's host is #{find_host(input_convert(gets.chomp))} #{find_emoji_of('kissing_heart')}"
else
  puts 'Please install gemoji first.'
end
