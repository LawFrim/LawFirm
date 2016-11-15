class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def lawyer_required
     if !current_uyser.lawyer?
      redirect_to "/"
      end
   end
end
