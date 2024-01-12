module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def log_out
    click_on 'Log out'
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finish_all_ajax_request?
    end
  end

  def finish_all_ajax_request?
    page.evaluate_script('jQuery.active').zero?
  end

  def select_by_value(id, value)
    option_xpath = "//*[@id='#{id}']/option[@value='#{value}']"
    option = find(:xpath, option_xpath).text
    select(option, from: id)
  end
end
