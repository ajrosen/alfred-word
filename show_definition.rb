#!/usr/bin/ruby

require 'json'.freeze

response = JSON.parse(ENV['response'])

words = response['results'].select { |e| e['definition'] == ARGV[0] }
word = words[0]

# Word
puts "# #{response['word']}"

# Pronunciation
if response['pronunciation']
  puts
  puts "| *#{response['pronunciation']['all']}* | #{response['syllables']['list']}"
end

# Definition and part of speech
puts
puts "`#{word['partOfSpeech']}` #{word['definition']}"

# Derivations
if word['derivation']
  puts
  puts "*#{word['derivation']}*"
end

# Synonyms
if word['synonyms']
  puts
  puts '**Synonyms**'

  word['synonyms'].each_with_index do |s, i|
    puts "#{i + 1}. #{s}"
  end
end

# Antonyms
if word['antonyms']
  puts
  puts '**Antonyms**'

  word['antonyms'].each_with_index do |s, i|
    puts "#{i + 1}. #{s}"
  end
end

# Examples
if word['examples']
  puts
  puts '**Examples**'

  word['examples'].each_with_index do |s, i|
    puts "#{i + 1}. *#{s}*"
  end
end

puts md
