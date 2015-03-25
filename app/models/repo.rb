class Repo < ActiveRecord::Base
  belongs_to :user

  # def get_repos
  # repo_list = HTTParty.get("https://api.github.com/users/#{user.name}/repos", 
  #   headers: {"Authorization" => "token #{Figaro.env.github_token}", 
  #   "User-Agent" => "#{Figaro.env.github_name}"})
  #   repo_names = repo_list.map {|x| x["name"]}
  #   repo_names.each do |repo|
  #     Repo.find_or_create_by!(name: repo, user_id: user.id)
  #   end
  # end 
end