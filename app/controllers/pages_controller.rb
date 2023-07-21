class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:userpage, :user_check]
  respond_to :json

  def home
    render json: { message: 'message from home controller' }
  end

  def userpage
  end

  def user_check
    render json: current_user
  end
end
