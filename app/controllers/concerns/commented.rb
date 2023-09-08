module Commented
  extend ActiveSupport::Concern

  included do
    before_action :set_commentable, only: %i[add_comment]
    after_action :publish_comment, only: %i[add_comment]
  end

  def add_comment
    @comment = @commentable.comments.new(comment_params.merge(user_id: current_user.id))
    # link_remove = url_for([:delete, @comment, @commentable])
    respond_to do |format|
      if @comment.save
        format.json do
          render json: [@comment, { author_email: @comment.user.email }]
        end
      else
        format.json { render json: [@comment.errors.full_messages, { status: :unprocessable_entity }] }
      end
    end
  end

  def delete_comment
    @comment = Comment.find(params[:comment_id])
    respond_to do |format|
      if @comment.destroy
        format.json { render json: { id: @comment.id } }
      else
        format.json { render json: [@comment.errors.full_messages, { status: :unprocessable_entity }] }
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
    @commentable = model_class.find(params[:id])
  end

  def publish_comment
    return if @comment.errors.any?

    comment_hash = Hash[
      comment: {
        id: @comment.id,
        body: @comment.body,
        users_email: @comment.user.email,
        updated_at: @comment.updated_at.strftime('%m/%d/%Y %H:%M'),
        commentable: @comment.commentable_type.pluralize.downcase,
        commentable_type: @comment.commentable_type.downcase,
        commentable_id: @comment.commentable_id
      }
    ]

    ActionCable.server.broadcast 'comments_channel', comment_hash
  end
end
