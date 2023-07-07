class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    @vote = @question.votes.new(vote_params)
    @vote.update(user_id: current_user.id) unless current_user.author?(@question) 
    respond_to do |format|
      if @vote.save
        format.json { render json: [@vote] }
      else 
        format.json { render json: [@vote.errors.full_messages, status: :unprocessable_entity] }
      end
    end
  end

  def destroy
    @vote = Vote.find(params[:id])   
    @vote.destroy 
  end

  private

  def vote_params
    params.require(:vote).permit(:user_id, :liked, :question_id)
  end
end