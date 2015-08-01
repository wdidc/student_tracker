u = User.find_by(login:"jshawl")

Notification.destroy_all

User.all.each do |user|
  Notification.create([
    {creator: u, receiver: user, body:"Notifications are created when you @ mention someone by GitHub username."},
  ])
end
