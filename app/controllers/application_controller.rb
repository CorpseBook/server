class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_filter :authenticate_user_from_token, except: [:token]

  skip_before_filter :verify_authenticity_token

  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

   before_filter :cors_preflight_check
   after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
     headers['Access-Control-Allow-Origin'] = '*'
     headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
     headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
     headers['Access-Control-Max-Age'] = "1728000"
   end

   def cors_preflight_check
    p request.method
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

   def token

    authenticate_with_http_basic do |email, password|
      user = User.find_by(email: email)
        if user && user.password == password
          render json: { token: user.auth_token }
        else
          render json: { error: 'Incorrect credentials' }, status: 401
        end
    end
  end

  private

  def authenticate_user_from_token
    unless authenticate_with_http_token { |token, options| User.find_by(auth_token: token) }
       render json: { error: 'Bad Token'}, status: 401
     end
  end


end
