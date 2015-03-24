class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  serialize :auth_data, JSON

  # def self.from_omniauth auth
  #   email = auth.info.email
  #   raise "You must sign in with a #{DOMAIN} address" unless email.ends_with? DOMAIN
  #   where(email: email).first_or_create! do |u|
  #     u.password = SecureRandom.hex 64
  #     u.google_auth_id   = auth.id
  #     u.google_auth_data = auth.to_h
  #   end
  # end

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
  end

    # HTTP.get("https://api.github.com/users/#{person}/repos", 
    # headers: {"Authorization" => "token env.github_token", "User-Agent" => "env.github_name"})

end
