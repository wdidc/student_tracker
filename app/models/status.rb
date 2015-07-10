class Status < ActiveRecord::Base
  def student
    Student.find(self.github_id)
  end
end
