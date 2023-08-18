module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: %i[ like dislike reset ]
  end

  def like
    return if @votable.voted_by?(current_user)

    @vote = @votable.votes.new(user: current_user, liked: true)

    responde_to do |format|
      if vote.save 
        format.json { render json: [@vote, Vote.rank_of_votable(@votable)] }
      else 
        format.json { render json: [@vote.errors.full_messages, { status: :unprocessable_entity }] }
      end
    end
  end

  def dislike
    return if @votable.voted_by?(current_user)

    @vote = @votable.votes.new(user: current_user, liked: false)
    
    responde_to do |format|
      if vote.save 
        format.json { render json: [@vote, Vote.rank_of_votable(@votable)] }
      else
        format.json { render json: [@vote.errors.full_messages, { status: :unprocessable_entity }] }
      end
    end
  end

  def reset
    
  end

  private

  def model_class
    controller_name.classify.constantize
  end

  def set_votable
    @votable = model_class.find(params[:id])
  end
end