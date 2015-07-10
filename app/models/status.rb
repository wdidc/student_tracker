class Status < ActiveRecord::Base
  paginates_per 10
  def student
    Student.find(self.github_id)
  end
end
