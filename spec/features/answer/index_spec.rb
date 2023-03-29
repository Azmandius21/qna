require 'rails_helper'

feature 'Use can view the question and all answers', "
  In order to find an answer on the question
  As User
  I'd like be ablle to view all answers on the questions 
" do
  given!(:question) { create(:question) }
  
  scenario 'view all answers on the question page' do
    answers = []
    3.times{ |n| answers << question.answers.create(body: "#{n+1} answer")}
    visit question_path(question)

    expect(page).to have_content answers[0].body
    expect(page).to have_content answers[1].body
    expect(page).to have_content answers[2].body
  end
end