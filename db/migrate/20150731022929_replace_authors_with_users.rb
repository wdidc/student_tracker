class ReplaceAuthorsWithUsers < ActiveRecord::Migration
  def change
    Status.all.each do |s|
      if s.author
	u = User.find_by(name: s.author)
	s.update(user:u)
      end
    end
  end
end
