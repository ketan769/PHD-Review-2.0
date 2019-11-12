class AuthsController < ApplicationController
  def new
  end

  def create
    @auths = Auth.create(params.require(:auth).permit(:username,        
   :password))
   session[:user_id] = @auths.id
   redirect_to '/welcome'
  end
end
