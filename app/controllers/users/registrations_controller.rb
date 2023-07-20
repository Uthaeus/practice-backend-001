# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :authenticate_user!, only: [:update, :destroy]
  respond_to :json

  protected 

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :avatar])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :username, :avatar])
  end

  private

  def respond_with(resource, _opts = {})
    if request.method === 'POST' && resource.persisted?
      render json: {
        status: {code: 200, message: 'Signed up sucessfully.'},
        data: resource
      }, status: :ok
    elsif request.method === 'PUT' && resource.persisted?
      @user = User.find_by(id: current_user.id)
      @user.update({
        username: resource.username,
        email: resource.email,
        avatar: resource.avatar,
        password: resource.password,
        password_confirmation: resource.password_confirmation
      })
      render json: {
        status: {code: 200, message: 'Updated sucessfully.'},
        data: resource
      }, status: :ok
    elsif request.method === 'DELETE'
      @user = User.find_by(id: current_user.id)
      @user.destroy
      render json: {
        status: {code: 200, message: 'Deleted sucessfully.'},
        data: @user
      }, status: :ok
    else
      render json: {
        status: {message: 'User not found.'}
      }, status: :unprocessable_entity
    end
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
