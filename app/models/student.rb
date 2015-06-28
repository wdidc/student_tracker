class Student

	attr_accessor :github_id, :name

	def initialize(opts={})
		@name = opts[:name]
		@github_id = opts[:github_id]
	end

	def self.all
		all = HTTParty.get("http://api.wdidc.org/students")
		all.map do |student|
			Student.new({github_id: student["github_user_id"], name: student["name"]})
		end
	end

	def self.find(id)
		students = JSON.parse(HTTParty.get("http://api.wdidc.org/students").body)
		student = students.find{|student|student["github_user_id"] == id.to_i}
	end

	def color
    status = Status.where(github_id: self.github_id).last
    if status
    	return status.color
    end
	end

end
