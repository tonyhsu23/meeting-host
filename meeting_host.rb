#!/usr/bin/env ruby
require 'gemoji'

TEAM_MEMBERS = %w(Eugene Yiwen Leon Howard Tony Kellen)

def filter_input(answer)
  case answer
  when /(yes|y)/i
    roger_exist = true
  when /(no|n)/i
    roger_exist = false
  else
    roger_exist = false
  end
end

def find_host(roger_exist)
  TEAM_MEMBERS << 'Roger' if roger_exist
  TEAM_MEMBERS.sample
end

def gemoji_installed?
  `gem list gemoji -i`
end

if gemoji_installed?
  print "Is Roger here #{Emoji.find_by_alias('thinking').raw}  [y/n] "
  puts "Today's host is #{find_host(filter_input(gets.chomp))} #{Emoji.find_by_alias('kissing_heart').raw}"
else
  puts 'Please install gemoji first.'
end
