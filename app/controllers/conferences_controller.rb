class ConferencesController < ApplicationController
  before_action :logged_in_user
  
  def index
    @conferences = Conference.all
  end

  def show
    @conference = Conference.find(params[:id])
  end
end
