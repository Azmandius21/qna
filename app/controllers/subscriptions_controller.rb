class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question

  authorize_resource

  def create
    @subscription = current_user.subscriptions.new( question: @question)
    @subscription.save
  end

  def destroy
    @subscription = current_user.subscriptions.find_by(question_id: @question.id)
    @subscription&.destroy
  end

  private

  def find_question
    @question =Question.find(params[:question_id])
  end
end
