class ApplicationController < ActionController::Base
  protect_from_forgery

  def enviar_codigo
    if params[:requested] == "profesor" #validar con session posteriormente(solo profesor tiene session)
      logger.info "EMAIL: #{params[:correo_electronico]} - CODIGO! #{params[:codigo_acceso]}"
    else
      logger.info "SOLO UN PROFESOR PUEDE ENVIAR UN CODIGO"
    end
  end

end
