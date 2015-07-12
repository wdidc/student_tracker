class Student

        @@all = JSON.parse(HTTParty.get("http://api.wdidc.org/students").body)
	attr_accessor :github_id, :name, :squad

	def initialize(opts={})
		@name = opts[:name]
		@github_id = opts[:github_id]
		@squad = opts[:squad]
	end

	def self.all
	  studs = @@all.map do |student|
	    Student.new({
	      github_id: student["github_user_id"], 
	      name: student["name"],
	      squad: student["squad"].downcase
	    })
	  end
	  studs
	end

	def self.find(id)
		students = @@all
		student = students.find{|student|student["github_user_id"] == id.to_i}
	end

	def color
	  status = Status.where(github_id: self.github_id).last
	  if status
	    return status.color
	  end
	end

	def updated_at
	  status = Status.where(github_id: self.github_id).last
	  if status
	    return status.updated_at
	  end
	end


end
