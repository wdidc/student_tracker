class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :creator, class_name: "User", foreign_key: "creator"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver"
end