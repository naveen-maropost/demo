class Api::V1::ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def authenticate_user_from_token_using_email!
    if user_token = params[:user_token].blank? && request.headers["X-API-TOKEN"]
      params[:user_token] = user_token
    end
    if user_email = params[:email].blank? && request.headers["X-API-EMAIL"]
      params[:email] = email
    end
    user = user_email && User.find_by(email: user_email)

    if user
      if user.active_for_authentication?
        if Devise.secure_compare(user.authentication_token, user_token)
          sign_in user, store: false
        end
      else
        respond_to do |format|
          format.json { render json: {message: "Session Expired", type: "disabled"}.to_json, status: 403 }
          format.any { render text: "Session Expired", status: 403 }
        end
        return false
      end
    end
  end

end
