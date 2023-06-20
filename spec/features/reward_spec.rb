require 'rails_helper'

feature 'User can give reward', "
  In order to give reward for best answer
  As an authenticated user author of a question
  I'd like to be able to give reward
" do
  given!(:question_author) { create(:user) }
  given!(:question) { create(:question, author: question_author) }
  given!(:reward) { create(:reward, rewardable: question) }
  given!(:answer_author) { create(:user) }
  given!(:answers) { create_list(:answer, 3, question: question, author: answer_author) }

  scenario 'question author choose best answer ', js: true do
    sign_in(question_author)
    visit question_path(question)
    find('a.best-answer-link', match: :first).click
    log_out

    sign_in(answer_author)
    visit user_show_rewards_path(answer_author)
    save_and_open_page
    expect(page).to have_content 'MyReward'
  end
end
