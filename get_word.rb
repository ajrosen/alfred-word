#!/usr/bin/ruby

title = 'Get definitions for...'
arg = ''

word = ARGV[0].scan(/\w+/).join if ARGV[0]

if word.length.positive?
  title = "Get definitions for #{word}"
  arg = word
end

puts '{ "items": [ { "title": "' + title + '", "arg": "' + arg + '" } ] }'
