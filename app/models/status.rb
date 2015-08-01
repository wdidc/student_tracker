class Status < ActiveRecord::Base
  paginates_per 10
  belongs_to :user
  after_save :notify_if_mention
  def student
    Student.find(self.github_id)
  end
  def notify_if_mention
    mentions = self.body.scan(/@\w+/)
    mentions.each do |mention|
      u = User.find_by(login: mention.gsub(/@/,""))
      body = "#{self.user.name} mentioned you: <blockquote>#{self.body}</blockquote><br><a href='/#{self.github_id}#s#{self.id}'>View mention</a>"
      Notification.create(creator: self.user, receiver: u, body: body)
    end
  end
end
