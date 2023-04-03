require 'rails_helper'
require 'byebug'

feature 'User can delete a question', %q{
  In order to delete my question
  As an authenticated User
  I'd like ba able to delete only my questions
} do
  given!(:author_question) { create(:user, :with_question) }
  
  scenario 'Author delete only his question' do
    
    visit question_path(question)
    click_on 'Delete question'

    expect(page).to have_content 'Are you sure?'
    click_on 'Yes'
    expect(page).to have_content 'Question is deleted successfully.'
  end

  scenario 'Author tries delete question from another author' 
end