class PagesController < ApplicationController
  respond_to :json

  def home
    render json: { message: 'message from home controller' }
  end

  def userpage
  end

  def user_check
  end
end
