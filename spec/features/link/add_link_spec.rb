require 'rails_helper'

feature 'add links to objects', "
  In order to give more information about object (question or answer)
  As author of object
  I'd like be able to add links during creating object
" do
  given!(:author){ create(:user) }
  given(:question){ create(:question) }
  given(:gist_url){ "https://gist.github.com/Azmandius21/0d80fb9f91558acda58d627f3493e38d"}

  background { sign_in(author) }

  scenario'add link to question' do
    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'My title'
    fill_in 'Body', with: 'My question body'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url
    click_on 'Ask'
    expect(page).to have_link 'My gist', href: gist_url
  end

  scenario'add link to answer', js: true do 
    visit question_path(question)
    fill_in 'Body', with: 'My answer body'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url
    click_on 'Give'
    within '.answers' do
      expect(page).to have_link 'My gist', href: gist_url
    end
  end
end