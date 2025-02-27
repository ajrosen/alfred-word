#!/usr/bin/ruby

require 'json'.freeze


##################################################
# Pluralize

def plural(s)
  (s == 1)? '' : 's'
end


##################################################
# Main

response = JSON.parse(ENV['response'])

retval = {}
retval['items'] = []

response['results'].each do |result|
  subtitle = ''
  subtitle += result['partOfSpeech'] if result['partOfSpeech']
  subtitle += ", #{result['synonyms'].count} synonym#{plural(result['synonyms'].count)}" if result['synonyms']
  subtitle += ", #{result['antonyms'].count} antonym#{plural(result['antonyms'].count)}" if result['antonyms']
  subtitle += ", #{result['examples'].count} example#{plural(result['examples'].count)}" if result['examples']

  retval['items'].append({
      title: result['definition'],
      subtitle: subtitle,
      arg: result['definition'],
      variables: { word: result.to_json.to_s }
  })
end

puts retval.to_json
