class StatusesController < ApplicationController
  def index
      @students = HTTParty.get("http://api.wdidc.org/students")
      binding.pry
  end

end
