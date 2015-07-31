class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :creator, foreign_key: "user_id"
      t.integer :receiver, foreign_key: "user_id"
      t.text :body
      t.timestamps
    end
  end
end
