require 'rails_helper'

feature 'User can create an answer on the question', "
  In order to give an answer to the question
  From the page of current question
  As user
  I'd like be able to create an answer
" do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user try' do
    background { sign_in(user) }

    background { visit question_path(question) }

    scenario 'create an answer with valid data', js: true do
      fill_in 'Body', with: 'My answer text text text'
      click_on 'Give answer'

      expect(current_path).to eq question_path(question)
      within '.answers' do
        expect(page).to have_content 'My answer text text text'
      end
    end

    scenario 'create an answer with attached files', js: true do
      fill_in 'Body', with: 'My answer text text text'
      attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Give answer'

      within '.answers' do
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end

    scenario 'create an answer with invalid data', js: true do
      fill_in 'Body', with: ''
      click_on 'Give answer'

      expect(page).to have_content "Body can't be blank"
    end
  end

  describe 'Unauthenticated user try' do
    background { visit question_path(question) }

    scenario 'create an answer with valid data', js: true do
      expect(page).to_not have_css('form')
    end
  end
end
