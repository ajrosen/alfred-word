#!/usr/bin/ruby

require 'json'.freeze

response = JSON.parse(ENV['response'])

# Word
puts "# #{response['word']}"

# Pronunciation
if response['pronunciation']
  puts
  puts "| *#{response['pronunciation']['all']}* | #{response['syllables']['list']}"
end

# Definitions
response['results'].each_with_index do |s, i|
  puts
  puts "#{i + 1}. `#{s['partOfSpeech']}` #{s['definition']}"
  puts
end
