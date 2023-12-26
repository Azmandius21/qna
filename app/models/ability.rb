# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    can :read, :all
    can :create, [Question, Answer]
    can %i[update destroy], [Question, Answer], author_id: user.id
    # for select best answer
    can :select, Answer,  question: { author_id: user.id }
    # for voting
    can :like, [Question, Answer], author_id: !user.id
    can :dislikelike, [Question, Answer], author_id: !user.id
    can :reset, [Question, Answer], author_id: !user.id
    # for comment add and delete
    can :add_comment, Comment, :all
    can :delete_comment, Comment, user_id: user.id
    # for subscriptions
    can %i[create destroy], Subscription, user_id: user.id
  end
end
