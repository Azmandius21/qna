require 'rails_helper'

feature 'User can create an answer on the question', "
  In order to give an answer to the question
  From the page of current question
  As user
  I'd like be able to create an answer
" do
  given(:user){ create(:user)}
  given(:question){ create(:question)}

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'create an answer with valid data' do
    fill_in 'Body', with: 'My answer text text text'
    click_on 'Give answer'
    
    expect(page).to have_content 'Your answer created successfully.'
  end

  scenario 'create an answer with invalid data' do
    fill_in 'Body', with: ''
    click_on 'Give answer'
    
    expect(page).to have_content 'The answer body can\'t be blank.'
  end
end