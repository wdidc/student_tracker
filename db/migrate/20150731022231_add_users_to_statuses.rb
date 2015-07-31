class AddUsersToStatuses < ActiveRecord::Migration
  def change
    add_reference :statuses, :user, index: true, foreign_key: true
  end
end
