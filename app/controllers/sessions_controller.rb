class SessionsController < ApplicationController
  layout 'home'

  def new
    if session.present? && session[:user_id].present?
      redirect_by_profile
    end
  end

  def create
    user = Usuario.autenticar(params[:correo_electronico], params[:password])
    if user
      session[:user_id] = user.id
      session[:user_profile] = user.perfil
      redirect_by_profile
    else
      flash.now.alert = "Constraseña o Mail inválidos"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_profile] = nil
    redirect_to root_url, notice: "Logged out!"
  end

  def redirect_by_profile
    # Change this to new views with dashboards
    url = case session[:user_profile]
    when 'admin', 'god'
      '/profesor'
    when 'alumno'
      '/alumnos'
    else
      root_url
    end
    redirect_to url, notice: "Logged in!"
  end

end