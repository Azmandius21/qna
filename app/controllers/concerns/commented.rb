module Commented
  extend ActiveSupport::Concern
  
  included do
    before_action :set_commentable, only: %i[ add_comment delete_comment]
  end

  def add_comment
    @comment = @commenable.comments.new(comment_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @comment.save
        format.json { render json: [@comment]}
      else
        format.json { render json: [ @comment.errors.full_messages, { status: :unprocessable_entity }] }
      end
    end
  end

  def delete_comment
    byebug
    @comment = @commentable.comments.find_by(params[:id])
    comment_id = @comment.id
    respond_to do |format|
      if @comment.destroy
        format.json { render json: { id: comment_id } }
      else
        format.json { render json: [ @comment.errors.full_messages, { status: :unprocessable_entity }] }
      end
    end
  end

  private

  def comment_params
    params.permit(:body)  
  end

  def model_class
    controller_name.classify.constantize  
  end

  def set_commentable
    byebug
    @commentable = model_class.find(params[:id])    
  end
end