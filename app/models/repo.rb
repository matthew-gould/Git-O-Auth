class Repo < ActiveRecord::Base
  belongs_to :user

  def populate_names
    repo_list = HTTParty.get("https://api.github.com/users/#{current_user.name}/repos", 
    headers: {"Authorization" => "token #{Figaro.env.github_token}", 
    "User-Agent" => "#{Figaro.env.github_name}"})
  end  
end

# names = HTTParty.get("https://api.github.com/users/matthew-gould/repos", 
#     headers: {"Authorization" => "token 36c14d7b4935689ddafa582bdaba93e25001bd57", 
#     "User-Agent" => "matthew-gould"})