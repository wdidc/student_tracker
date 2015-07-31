token = ENV['token']
instructors = JSON.parse(HTTParty.get("https://api.github.com/teams/1511667/members?access_token=#{token}").body)
instructors.each do |inst|
  ins = JSON.parse(HTTParty.get(inst["url"]).body)
  u = User.find_by(uid: ins["id"])
  u.update(login: ins["login"])
end
