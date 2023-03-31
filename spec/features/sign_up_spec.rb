require 'rails_helper'

feature 'User can register', "
  In oreder to have all posiblelity
  As unregistered User
  I'd like to be able to regiter
" do

  given(:user){ create(:user)}
  background { visit new_user_registration_path }

  scenario 'regiter new user with valid data ' do
    fill_in 'Email', with: 'newuser@test.com'
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'
    
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'user tries register again with valid data ' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'
    
    expect(page).to have_content 'Email has already been taken'
  end

  scenario 'user tries register with invalid data' do

    fill_in 'Email', with: '123'
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: 'invalid_password'

    click_on 'Sign up'
    
    expect(page).to have_content 'Email is invalid'
    expect(page).to have_content 'Password confirmation doesn\'t match Password'
  end
end