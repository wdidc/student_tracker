class Status < ActiveRecord::Base
  paginates_per 10
  belongs_to :user
  def student
    Student.find(self.github_id)
  end
end
