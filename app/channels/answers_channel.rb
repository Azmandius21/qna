class AnswersChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'answers_channel'
  end
end