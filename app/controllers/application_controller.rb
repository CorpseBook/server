class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  skip_before_filter :verify_authenticity_token

  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  # INDENTATION! You know how much I like good indentation. :)
  # Seriously though it is important for readability for yourself
  # and your team.
  def cors_set_access_control_headers
     headers['Access-Control-Allow-Origin'] = '*'
     headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
     headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
     headers['Access-Control-Max-Age'] = "1728000"
   end

   def cors_preflight_check
     # Don't commit debugging code. Doing `git diff` before you
     # do `git add` or `git commit` will help prevent this.
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

     # Don't commit commented out code! It just sits and rots
     # in a codebase and no one ever cleans it up because no
     # one will be sure the reasons as to why it was there
     # or why it was commented out.
     # def set_csrf_cookie_for_ng
     #    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
     #  end

   end


end
