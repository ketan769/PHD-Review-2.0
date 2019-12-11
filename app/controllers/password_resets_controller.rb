class PasswordResetsController < ApplicationController
  def new
  end
  def create
    auth= Auth.find_by(email: params[:email])
    if auth
      auth.send_password_reset
      flash[:alert] = "Password reset link sent"
      redirect_to '/login'
    else
      flash[:alert] = "Invalid Email!"
      redirect_to '/login'
    end
  end
  
  def edit
  @auth = Auth.find_by_password_reset_token!(params[:id])
  end
  
  def update
  @auth = Auth.find_by_password_reset_token!(params[:id])
  if @auth.password_reset_sent_at < 2.hour.ago
    flash[:notice] = 'Password reset has expired'
    redirect_to new_password_reset_path
  elsif @auth.update(auth_params)
    flash[:alert] = 'Password has been reset!'
    redirect_to '/login'
  else
    render :edit
  end
  end
  
  private 
    def auth_params
      params.require(:auth).permit(:password)
    end

end
