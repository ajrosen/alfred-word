#!/usr/bin/ruby

require 'json'.freeze

response = JSON.parse(ENV['response'])
extras = []

response['results'].each do |result|
  result[ARGV[0]].each do |s|
    extras.push(s)
  end if result[ARGV[0]]
end

extras.uniq!
extras.sort!

puts "# #{ARGV[0]}"

extras.each_with_index do |s, i|
  puts "#{i + 1}. #{s}"
end
