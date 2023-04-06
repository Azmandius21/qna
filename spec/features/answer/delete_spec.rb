require 'rails_helper'

feature 'User can delete an answer', %q{
  In order to delete my answer
  As an authenticated User
  I'd like ba able to delete only my answer
} do
  given(:author) { create(:user) }
  given(:question) { create(:question, author_id: author.id)}
  given(:answer) { create(:answer, question_id: question.id, author_id: author.id) }

  scenario 'Author delete only his answer' do    
    sign_in(author)
    visit answer_path(answer)
    click_on 'Delete'
    expect(page).to have_content 'The answer deleted successfully.'
  end

  given(:user) { create(:user) }  

  scenario 'User tries delete question from another author' do
    sign_in(user)    
    visit answer_path(answer)
    click_on 'Delete'
    expect(page).to have_content 'Only author of the answer can remove it.'
  end
end