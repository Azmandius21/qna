class QuestionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "question_channel#{params[:question_id]}"
  end
end