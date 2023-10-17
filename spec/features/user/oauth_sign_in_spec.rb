require 'rails_helper'

feature 'User can sign in through OAuth', "
  In order to eazy sign in
  As an unauthenticated user
  I'd like to be able to use Vk and GitHub accaunt
  " do

    scenario 'sign in via Github account' do
      visit new_user_session_path
      expect(page).to have_content 'Sign in with GitHub'

      mock_auth_hash('github', 'user@test.com')
      click_link 'Sign in with GitHub'

      if page.has_content? 'You have to confirm your email address before continuing.'
        open_email 'user@test.com'
        current_email.click_link 'Confirm my account'

        expect(page).to have_content 'Your email address has been successfully confirmed.'

        click_link 'Sign in with GitHub'

      end

      expect(page).to have_content 'Successfully authenticated from Github account.'
    end

    scenario 'sign in via Vkontakte account' do
      visit new_user_session_path
      expect(page).to have_content 'Sign in with Vkontakte'

      mock_auth_hash('vkontakte', nil)
      # save_and_open_page
      click_link 'Sign in with Vkontakte'

      expect(page).to have_content 'Enter you email'
      fill_in 'Enter you email', with: 'user@test.com'

      open_email('user@test.com')
      current_email.click_link 'Confirm my account'

      click_link 'Sign in with Vkontakte'

      expect(page).to have_content 'Successfully authenticated from Vkontakte account.'
    end
  end
