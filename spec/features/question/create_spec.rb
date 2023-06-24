require 'rails_helper'

feature 'User can create a question', "
  In order to get answer from a comunity
  As an authenticated User
  I'd like be able to ask the question
" do
  given(:user) { create(:user) }

  describe 'Authenticated User' do
    background do
      sign_in(user)

      visit questions_path
      click_on 'Ask question'
    end

    scenario 'ask a question' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created.'
      expect(page).to have_content 'Test question'
      expect(page).to have_content 'text text text'
    end

    scenario 'ask a question with reward' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'
      fill_in 'Reward name', with: 'MyReward'
      attach_file 'Image', "#{Rails.root}/spec/support/assets/reward.png"
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created.'
      expect(page).to have_content 'Test question'
      expect(page).to have_content 'text text text'
      expect(page).to have_link 'MyReward'
    end

    scenario 'ask a question with attached fille' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'

      attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Ask'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    scenario 'ask a question with error' do
      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
    end
  end

  scenario 'Unauthenticated User ask a question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
