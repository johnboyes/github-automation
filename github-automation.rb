require 'octokit'

$stdout.sync = true #so we can see stdout when starting with foreman, see https://github.com/ddollar/foreman/wiki/Missing-Output

ORG=ENV['ORG']
TEAM_ID=ENV['TEAM_ID']

CLIENT = Octokit::Client.new(:access_token => ENV['ACCESS_TOKEN'], :auto_paginate => true)

def add_all_repositories_except_excluded_to_team
  CLIENT.org_repos(ORG).each { |repository| CLIENT.add_team_repository(TEAM_ID, repository.full_name) unless repository.name == ENV['EXCLUDE'] }
end

def add_all_members_in_org_to_team
  CLIENT.org_members(ORG).each { |org_member| CLIENT.add_team_member(TEAM_ID, org_member.login) }
end