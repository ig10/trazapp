class PublicController < ApplicationController
  layout 'home'

  def index
    @usuario = Usuario.new

  end

  def login
    render json: {status: "ACA ME LOGEO"}.to_json
  end

end