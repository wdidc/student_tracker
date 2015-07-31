User.destroy_all

token = ENV['token']
instructors = JSON.parse(HTTParty.get("https://api.github.com/teams/1511667/members?access_token=#{token}").body)
instructors.each do |inst|
  ins = JSON.parse(HTTParty.get(inst["url"]).body)
  User.create(uid: ins["id"], provider: "github", name: ins["name"], avatar_url: ins["avatar_url"])
end
