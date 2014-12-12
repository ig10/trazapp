class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_for_user

  def enviar_codigo
    if params[:requested] == "profesor" #validar con session posteriormente(solo profesor tiene session)
      logger.info "EMAIL: #{params[:correo_electronico]} - CODIGO! #{params[:codigo_acceso]}"
    else
      logger.info "SOLO UN PROFESOR PUEDE ENVIAR UN CODIGO"
    end
  end

  helper_method :current_user
  helper_method :layout_for_user

  private

    def current_user
      @current_user ||= Usuario.find(session[:user_id]) if session[:user_id]
    end

    def layout_for_user
      begin
        current_user.admin? ? 'admin' : 'alumno'
      rescue Exception => e
        'home'
      end
    end

end
