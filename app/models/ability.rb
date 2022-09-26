# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize user
    can :read, Product
    if user&.admin?
      can :manage, :all
    elsif user&.customer?
      can %i(read create), Order, user_id: user.id
      can :update, Order, user_id: user.id, status: :pending
      can :manage, User, id: user.id, role: :customer
      cannot :destroy, User, id: user.id, role: :customer
      can :manage, :cart
    end
  end
end
