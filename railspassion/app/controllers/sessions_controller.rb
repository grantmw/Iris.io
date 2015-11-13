require 'bcrypt'

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    p '*' * 100
    p params
    p user.password
    p params[:session][:password]
    p '*' * 100
    if user.password == params[:session][:password]
      session[:id] = user.id
      session[:tries] = 0
      p '*' * 1000
      redirect_to '/'
    else
      # Create an error message.
      render 'new'
    end
  end

  def destroy
    p "69" * 100
    session.destroy
    redirect_to '/login'
  end

end
