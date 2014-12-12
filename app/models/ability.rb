class Ability
  include CanCan::Ability

  def initialize(usuario)
    @usuario = (usuario ||= Usuario.new)
    send(@usuario.perfil) unless @usuario.perfil.blank?
  end

  def god
    can :manage, :all
  end

  def admin
    can :manage, :all
    can :aprobar, TmpProyecto
  end

  def profesor
    admin
    can :edit, Usuario, id: @usuario.id
  end

  def alumno
    cannot :manage, :all
    cannot :aprobar, TmpProyecto
    can :edit, Usuario, id: @usuario.id
  end

end
