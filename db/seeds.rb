u = User.find_by(login:"jshawl")
u2 = User.find_by(login:"adambray")

Notification.destroy_all
Notification.create([
  {creator: u2, receiver: u, body:"this is the body"},
  {creator: u2, receiver: u, body:"a second notification"}
])
