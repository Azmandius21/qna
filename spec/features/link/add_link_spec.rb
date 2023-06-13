require 'rails_helper'

feature 'add links to objects', "
  In order to give more information about object (question or answer)
  As author of object
  I'd like be able to add links during creating object
" do
  given!(:author){ create(:user) }
  given(:question){ create(:question) }
  given(:link_url){ "https://Azmandius21/0d80fb9f91558acda58d627f3493e38d"}
  given(:gist_url){ "https://gist.github.com/Azmandius21/db01c544addfb9d6d9358077b7402718"}

  background { sign_in(author) }

  scenario'add link to question', js: true do
    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'My title'
    fill_in 'Body', with: 'My question body'

    fill_in 'Link name', with: 'My link'
    fill_in 'Url', with: link_url
    click_on 'Ask'
    expect(page).to have_link 'My link', href: link_url
  end

  scenario'add link to answer', js: true do 
    visit question_path(question)
    fill_in 'Body', with: 'My answer body'

    fill_in 'Link name', with: 'My link'
    fill_in 'Url', with: link_url
    click_on 'Give'
    within '.answers' do
      expect(page).to have_link 'My link', href: link_url
    end
  end

  scenario 'add gist link to question', js: true do
    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'My title'
    fill_in 'Body', with: 'My question body'

    fill_in 'Link name', with: 'My gist link'
    fill_in 'Url', with: gist_url
    click_on 'Ask'
    click_on 'Show gist content'
    expect(page).to_not have_link 'My gist link', href: gist_url
    expect(page).to have_css '.gist-link'
  end

  scenario 'add gist link to answer' , js: true do
    visit question_path(question)
    fill_in 'Body', with: 'My answer body'

    fill_in 'Link name', with: 'My gist link'
    fill_in 'Url', with: gist_url
    click_on 'Give answer'
    within '.answers' do
      click_on 'Show gist content'
      click_on 'Show gist content'

      expect(page).to_not have_link 'My gist link', href: gist_url
      expect(page).to have_css '.gist-link'
      expect(page).to have_content 'Gist content'
    end
  end
end