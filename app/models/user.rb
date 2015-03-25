class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  serialize :auth_data, JSON

  has_many :repos

  def self.from_omniauth data
    github_id = data.uid
    if user = User.find_by(github_id: github_id)
      user
    else
      where(github_id: github_id).create! do |u|
        u.password = SecureRandom.hex 64
        u.name = data.info.nickname
        u.email = data.info.email
        u.github_id = data.uid
        u.auth_data = data
      end
    end
    repo_list = HTTParty.get("https://api.github.com/users/#{user.name}/repos", 
    headers: {"Authorization" => "token #{Figaro.env.github_token}", 
    "User-Agent" => "#{Figaro.env.github_name}"})
    repo_names = repo_list.map {|x| x["name"]}
    repo_names.each do |repo|
      Repo.find_or_create_by!(name: repo, user_id: user.id)
    end
    user
  end
end
