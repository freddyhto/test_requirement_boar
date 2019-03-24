class SessionsController < ApplicationController
  before_filter :session_params, only: [:create]
  respond_to :json

  def new
  end

  def create
    session['session_id'] = SecureRandom.base64
    @user = User.find_by_email params[:email]
    if @user.present?
      @user.update_attribute(:session_token, session['session_id'])
    else
      @user = User.create({email: params[:email],
                           name: params[:name],
                           session_token: session['session_id']})
    end
  end

  def destroy
     current_user.update_attribute(:session_token, nil)
  end

  private
    def session_params
      params.require(:user).permit(:email, :name, :session_token)
    end

end