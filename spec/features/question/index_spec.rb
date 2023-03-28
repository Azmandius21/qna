require 'rails_helper'

feature 'User can view list of questions', %q{
  In order to find my question among all questions
  As an anauthenticated User
  I'd like to be able to view list of all questions
} do
  given!(:questions) {create_list(:question, 3)}
  
  scenario 'Anauthenticated User view list of questions'do
    visit questions_path
    expect(page).to have_content(questions[0].title)
    expect(page).to have_content(questions[1].title)
    expect(page).to have_content(questions[2].title)
  end
end