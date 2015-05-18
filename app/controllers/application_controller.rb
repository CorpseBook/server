class ApplicationController < ActionController::API
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_filter :cors_preflight_check, :authenticate_user_from_token, except: [:token, :options, :sign_up]

  skip_before_filter :verify_authenticity_token

  # protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  before_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
     headers['Access-Control-Allow-Origin'] = '*'
     headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
     headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
     headers['Access-Control-Max-Age'] = "1728000"
   end

   def cors_preflight_check
     if request.method == 'OPTIONS'
       # headers['Access-Control-Allow-Origin'] = '*'
       # headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
       # headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
       # headers['Access-Control-Max-Age'] = '1728000'

       headers['Access-Control-Allow-Origin'] = '*'
       headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
       headers['Access-Control-Request-Method'] = '*'
       headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
       headers['Access-Control-Allow-Credentials'] = 'true'
       headers['Access-Control-Max-Age'] = '1728000'

       render :text => '', :content_type => 'text/plain'
     end

     # def set_csrf_cookie_for_ng
     #    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
     #  end

   end

   # A user can sign up with email + password and is assigned a auth_token

  def options
    render text: ""
  end

   def sign_up
    user = User.new(user_params)
    if user.save
      render status: 200, json: { token: user.auth_token }
    else
      render json: { error: 'Incorrect user information' }, status: 401
    end
   end

   # A user can login with email + password. Their auth_token is rendered. The client must save the token as an Authorization header. This will then be sent with every request made to the API for authentication.
   # For Ajax:
   # $.ajaxSetup({
   #     headers: { 'Authorization': "Token token="+token }
   # });

   def token
    user = User.find_by(email: user_params[:email])
    if user && user.password == user_params[:password]
        render json: { token: user.auth_token, user: user }
      else
        render json: { error: 'Incorrect credentials' }, status: 401
    end
    # authenticate_with_http_basic do |email, password|
    #   puts "inside the do"
    #   user = User.find_by(email: params[:email])
    #   if user && user.password == params[:password]
    #     render json: { token: user.auth_token }
    #   else
    #     render json: { error: 'Incorrect credentials' }, status: 401
    #   end
    # end
  end

  # A user can sign out by having their auth_token reset. Their Authorization header will no longer match and fail to pass authentication

  def sign_out
    authenticate_with_http_token do |token, options|
       user = User.find_by(auth_token: token)
       user.auth_token = SecureRandom.hex
      render json: {message: "You have signed out."}
    end
  end

  private

  def authenticate_user_from_token
    unless authenticate_with_http_token { |token, options|
      User.find_by(auth_token: token) }
       render json: { error: 'Bad Token'}, status: 401
     end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end


end
