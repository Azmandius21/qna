require 'rails_helper'

feature 'User can log out', "
  In order to finish session
  As an authenticated user
  I'd like to be able sign out
" do
  given(:user) { create(:user) }

  scenario 'Registered user tries sign out' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    click_on 'Log out'
    expect(page).to have_content 'Signed out successfully.'
  end
end
