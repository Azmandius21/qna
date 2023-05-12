require 'rails_helper'

feature 'Choosing best answer', "
In order to choose best answer on my question
As an author of question
I'd like be able to choose one best answer
" do
  given!(:author) { create(:user) }
  given!(:question) { create(:question, author: author) }
  given!(:answers) { create_list(:answer, 3, question: question, author: author) }

  scenario 'author question choose best answer ', js: true do
    sign_in(author)
    visit question_path(question)

    expect(page).to have_content answers[0].body
    expect(page).to have_content answers[1].body
    expect(page).to have_content answers[2].body

    best_answer_id = answers[1].id

    within ".answer-#{best_answer_id}" do
      click_on 'Best answer'
    end

    visit question_path(question)

    within '.answers' do
      expect(page).to have_css '.best-answer'
    end
  end
end
