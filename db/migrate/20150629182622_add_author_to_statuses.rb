class AddAuthorToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :author, :string
  end
end
