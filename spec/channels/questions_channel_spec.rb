require 'rails_helper'

RSpec.describe QuestionsChannel, type: :channel do
  
  it 'successfully subscribes' do
    subscribe
    expect(subscription).to be_confirmed
  end

  it 'presence stream from Question' do
    subscribe
    expect(subscription).to have_stream_from("questions_channel")
  end
end