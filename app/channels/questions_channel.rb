class QuestionsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'questions_channel'
  end

  def do_something(data)
    Rails.logger.info data
  end

  def echo(data)
    transmit data
  end
end
