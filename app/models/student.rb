class Student
	
	attr_accessor :github_id, :name

	def initialize(opts={}) 
		@name = opts[:name]
		@github_id = opts[:github_id]
	end

	def self.all
		all = HTTParty.get("http://api.wdidc.org/students")
		binding.pry
		all.map do |student|
			Student.new({github_id: student["github_user_id"], name: student["name"]})
		end
	end

	def self.find(id)
		JSON.parse(HTTParty.get("http://api.wdidc.org/students/#{id}").body)
	end

	def color
    status = Status.where(github_id: self.github_id).last
    if status 
    	return status.color
    end
	end

end