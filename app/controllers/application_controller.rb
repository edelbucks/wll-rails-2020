class ApplicationController < ActionController::API

  def authtoken_header
    @auth_token ||= request.headers['access_token']
  end

  def check_auth()
    unless authtoken_header
      render_error 401, 'no authtoken header'
      false
    end

  end

end
