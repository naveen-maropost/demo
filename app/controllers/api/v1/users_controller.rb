class Api::V1::UsersController < Api::V1::ApiController
  layout false
  before_action :authenticate_user_from_token_using_email!, :only => [:index]
  before_action :authenticate_user!, :except => [:sign_in_user,:sign_up_user,:forgot_password, :destroy]

  def sign_in_user
    user = User.find_by(email: params[:email])
    respond_to do |format|
      if user && user.valid_password?(params[:password])
        user.ensure_authentication_token
        sign_in user
        format.json { render json: { auth_token: user.authentication_token, status:"Success", message: "Successfully Sign In", code: 200}.to_json }
      else
        format.json { render json: { status:"Failure", message: "Wrong Email Or Password", code: 500 }.to_json}
      end
    end
  end

  def sign_up_user
    user = User.new(user_params)
    user.save
    render json: user
  end

  def destroy
    respond_to do |format|
      user = User.find_by_authentication_token(request.headers['X-API-TOKEN'])
      if user
        user.reset_authentication_token
        user.save
        format.json { render :json => { :message => 'Session deleted.', :status => "Success", :code => 200}.to_json }
      else
        format.json { render :json => { :message => 'Invalid token.', :status => "Failure", code: 500 }.to_json }
      end
    end
  end


  def forgot_password
    user = User.find_by_email(params[:email])
    respond_to do |format|
      if user
        user.send_reset_password_instructions
        format.json { render json: {status:"Success", message: "We sent an email with reset password instruction", :code => 200 }.to_json }
      else
        format.json { render json: {status:"Failure", message: "Your email is does not exist, please sign up.", :code => 500 }.to_json }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email,:password,:password_confirmation)
  end

end
