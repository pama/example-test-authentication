require "application_system_test_case"
require "macros/authentication"

class SignsInTest < ApplicationSystemTestCase

  def setup
    visit new_user_session_path
  end

  test 'Responds to login path' do
    assert_equal current_path, new_user_session_path
    assert page.has_content? 'Log in'
  end

  test 'Fails without email' do
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    assert page.has_text? 'Invalid Email or password.'
  end

  test 'Fails with and invalid email' do
    fill_in 'Email', with: 'whatever'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    message = page.find("#user_email").native.attribute("validationMessage")
    assert_equal "Please include an '@' in the email address. 'whatever' is missing an '@'.", message
  end

  test 'Fails without password' do
    fill_in 'Email', with: 'admin@test.com'
    click_button 'Log in'

    assert page.has_content? 'Invalid Email or password.'
  end

  test 'Logs in with with a valid and active user' do
    fill_in :user_email, with: 'norah.jones@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    assert page.has_content? 'Signed in successfully.'
  end
end
