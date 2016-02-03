module CheckLoginConcern
  # extend ActiveSupport::Concern

  def check_login
    unless logged_in
      user_intended = {
        request_method: request.method,
        request_path: request.path,
        request_referer: request.referer
      }
      session[:user_intended] = user_intended

      flash[:errors] = ["You need to login to perform this action"]
      redirect_to login_path
    end
  end
end
