#!/usr/bin/ruby

require 'json'.freeze

##################################################
# Pluralize

def plural(num)
  num == 1 ? '' : 's'
end

def extras(key, value)
  value.uniq!

  title = format('%<num>d %<key>s%<plural>s',
                 {
                   num: value.count,
                   key: key,
                   plural: plural(value.count)
                 })

  { title: title, arg: "#{key}s" }
end

##################################################
# Main

def main(response)
  retval = []

  definitions = []
  synonyms = []
  antonyms = []
  examples = []

  if response['syllables']
    # Pronunciation and syllables
    syllables = response['syllables']

    title = format('%<word>s (%<count>d syllable%<plural>s)',
                   {
                     word: response['pronunciation']['all'],
                     count: syllables['count'],
                     plural: plural(syllables['count'])
                   })
    subtitle = response['syllables']['list'].to_s
    arg = response['pronunciation']['all']

    retval.append({ title: title, subtitle: subtitle, arg: arg })
  else
    retval.append({ title: response['word'], arg: response['word'] })
  end

  # Counts
  response['results'].each do |result|
    definitions.append(result['definition']) if result['definition']
    synonyms += result['synonyms'] if result['synonyms']
    antonyms += result['antonyms'] if result['antonyms']
    examples += result['examples'] if result['examples']
  end

  # Definitions, synonyms, antonyms, examples
  retval.append(extras('definition', definitions))
  retval.append(extras('synonym', synonyms))
  retval.append(extras('antonym', antonyms))
  retval.append(extras('example', examples))

  retval
end

##################################################
# Main

response = JSON.parse(ENV['response'])

retval = {}

retval['items'] =
  if response['message']
    [{ title: response['message'], subtitle: ENV['word'], arg: 'failure' }]
  else
    main(response)
  end

puts retval.to_json
