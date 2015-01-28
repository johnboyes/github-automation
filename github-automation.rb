require 'github_api'

puts Github.new basic_auth: "#{ENV['GITHUB_USER']}:#{ENV['GITHUB_PASSWORD']}"