class DataWorker # < ActiveJob::Base
include Sidekiq::Worker
include Sidetiq::Schedulable

recurrence { hourly.minute_of_hour(0) }

  def perform
    repo_stats = HTTParty.get("https://api.github.com/repos/:owner/:repo", 
    headers: {"Authorization" => "token #{Figaro.env.github_token}", 
    "User-Agent" => "#{Figaro.env.github_name}"})
    repo_commits = HTTParty.get
    ("https://api.github.com/repos/:owner/:repo/stats/participation", 
    headers: {"Authorization" => "token #{Figaro.env.github_token}", 
    "User-Agent" => "#{Figaro.env.github_name}"})
  end
end

# HardWorker.perform_async('bob', 5)

# commits:
# HTTParty.get("https://api.github.com/repos/:owner/:repo/stats/participation

# stars/watchers:
# HTTParty.get("https://api.github.com/repos/:owner/:repo