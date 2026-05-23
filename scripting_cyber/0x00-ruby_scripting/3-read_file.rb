#!/usr/bin/env ruby

require 'json'

def count_user_ids(path)
  data = JSON.parse(File.read(path))
  counts = data.map { |item| item['userId'] }.tally
  
  counts.sort.each { |user_id, count| puts "#{user_id}: #{count}" }
end
