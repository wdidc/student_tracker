class User < ActiveRecord::Base
  has_many :statuses

  def is_an_instructor? token
    instructors = HTTParty.get("https://api.github.com/teams/1511667/members?access_token=#{token}")
    instructors.each do |instructor|
      if self.uid.to_i == instructor["id"].to_i
	return true
      end
    end
    return false
  end

  def self.from_auth auth_hash
    user = find_or_initialize_by(uid: auth_hash[:uid], provider: auth_hash[:provider])
    user.name = auth_hash[:info][:name]
    user.avatar_url = auth_hash[:info][:image]
    token = auth_hash[:credentials][:token]
    if user.is_an_instructor? token
      user.save
      user
    end
  end
end