class Student
	def self.all
		HTTParty.get("http://api.wdidc.org/students")
	end

	def self.find(id)
		JSON.parse(HTTParty.get("http://api.wdidc.org/students/#{id}").body)
	end

end