#!/usr/bin/env ruby

def gemoji_installed?
  filter_string(`gem list gemoji -i`) == 'true'
end

def find_emoji_of(name)
  Emoji.find_by_alias(name).raw
end

def filter_string(s)
  s.chomp.gsub(/\s+/, '')
end

def input_convert(answer)
  case answer
  when /(yes|y)/i then true
  when /(no|n)/i  then false
  else;                false
  end
end

def create_team_file
  File.open('team', 'w') do |file|
    print 'Enter team leader name: '
    file.write(filter_string(gets) + ',')
    print 'Enter team member names split with comma: '
    file.write(filter_string(gets) + "\n")
    file.close
  end
end

def import_team_members
  members = IO.foreach('team').to_a[0].chomp.split(',')
  @team_leader  = members.first
  @team_members = members[1..-1]
end

def find_host(leader_exist)
  @team_members << @team_leader if leader_exist
  @team_members.sample
end

def main_action
  require 'gemoji'
  create_team_file unless File.file?('team')
  import_team_members
  print "Is #{@team_leader} here #{find_emoji_of('thinking')}  [y/n] "
  puts "Today's host is #{find_host(input_convert(gets.chomp))} #{find_emoji_of('kissing_heart')}"
end

if gemoji_installed?
  main_action
else
  print "Cannot find gemoji, do you want to install now? [y/n] "
  if input_convert(gets.chomp)
    puts `gem install gemoji`
    puts "\n"
    main_action
  else
    puts "That's fine, you can install it later."
  end
end
