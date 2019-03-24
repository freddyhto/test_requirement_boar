class OauthController < ApplicationController

  def authorization_request
    #redirect to google to get permissions
    redirect_to Oauth.authorization_request_url
  end

  def callback
    if params[:error].blank?
      response = Oauth.authorization_grant_request params[:code]
      user_info = Oauth.get_user_info response[:access_token]
      session['session_id'] = SecureRandom.base64
      @user = User.create({email: user_info['email'],
                           name:  user_info['name'],
                           session_token: session['session_id']})
    else
      redirect_to session_new_path 
    end
  end

end
