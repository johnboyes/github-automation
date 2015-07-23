require 'octokit'

$stdout.sync = true #so we can see stdout when starting with foreman, see https://github.com/ddollar/foreman/wiki/Missing-Output

ORG=ENV['ORG']
TEAM_ID=ENV['TEAM_ID']

client = Octokit::Client.new(:access_token => ENV['ACCESS_TOKEN'], :auto_paginate => true)

def add_all_repositories_except_excluded_to_team
  client.org_repos(ORG).each { |repository| client.add_team_repository(TEAM_ID, repository.full_name) unless repository.name == ENV['EXCLUDE'] }
end

def add_all_members_in_org_to_team
  client.org_members(ORG).each { |org_member| client.add_team_member(TEAM_ID] org_member.login) }
end