class SessionsController < ApplicationController
  def new
   session[:user]=nil
  end

  def create
   @auth = Auth.find_by(username: params[:username])
   if(params[:password] == "0000" || params[:password] == "")
       flash[:alert] = "Please create a password before logging in by clicking on Change Password?"
       redirect_to '/login'
   elsif @auth && @auth.authenticate(params[:password])
      session.clear
      session[:auth_id] = @auth.id
      session[:user] = params[:username]
      redirect_to '/searches/new'
   else
      flash[:alert] = "Username or password is invalid"
      redirect_to '/login'
   end
  end

  def login
  end
  def welcome
  end
 
end
