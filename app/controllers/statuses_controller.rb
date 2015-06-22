class StatusesController < ApplicationController
  def index
    @students = HTTParty.get("http://api.wdidc.org/students")
  end

  def create

  end

  private
  def status_params

  end
end
