class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string, :color
      t.string :github_id
      t.string :integer,
      t.string :body

      t.timestamps null: false
    end
  end
end
