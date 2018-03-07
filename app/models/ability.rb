class Ability
  include CanCan::Ability

  def initialize user, controller_namespace = nil
    # return undefine_user if user.blank?
    if user.present?
      case user.permission
      when "admin"
        permission_admin
      else
        permission_user user
      end
    end
  end

  private

  def permission_admin
    can :manage, :all
  end

  def permission_user user
    can :read, User
    can :update, User, id: user.id
  end
  # def undefine_user
  #   can :create, Apply
  #   can :read, :all
  # end
end