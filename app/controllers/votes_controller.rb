class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @user.votes.create(vote_params)
  end

  def destroy
    @vote = Vote.find(params[:id])   
    @vote.destroy 
  end

  private

  def vote_params
    params.require(:vote).permit(:user_id, :liked, :votable_id)
  end
end