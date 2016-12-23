#!/usr/bin/env ruby
require 'gemoji'

TEAM_LEADER  = 'Roger'
TEAM_MEMBERS = %w(Eugene Yiwen Leon Howard Tony Kellen)

def input_convert(answer)
  case answer
  when /(yes|y)/i then true
  when /(no|n)/i  then false
  else;                false
  end
end

def find_host(leader_exist)
  TEAM_MEMBERS << TEAM_LEADER if leader_exist
  TEAM_MEMBERS.sample
end

def gemoji_installed?
  `gem list gemoji -i`
end

def find_emoji_of(name)
  Emoji.find_by_alias(name).raw
end

if gemoji_installed?
  print "Is #{TEAM_LEADER} here #{find_emoji_of('thinking')}  [y/n] "
  puts "Today's host is #{find_host(input_convert(gets.chomp))} #{find_emoji_of('kissing_heart')}"
else
  puts 'Please install gemoji first.'
end
