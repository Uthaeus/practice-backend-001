# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private 

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Logged in sucessfully.'},
        data: current_user
      }, status: :ok
    else
      render json: {
        status: {message: 'User not found.'},
        data: resource.errors
      }, status: :unprocessable_entity
    end
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
    current_user = User.find(jwt_payload['sub'])
    if current_user
      render json: {
        status: {code: 200, message: 'Logged out sucessfully.'}
      }, status: :ok
    else
      render json: {
        status: {message: 'User not found.'}
      }, status: :unprocessable_entity
    end
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
