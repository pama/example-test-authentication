require "application_system_test_case"
require 'macros/authentication'

class SignsUpTest < ApplicationSystemTestCase

  def setup
    visit new_user_registration_path
  end

  test 'Responds to registration path' do
    assert_equal current_path, new_user_registration_path
    assert page.has_content? 'Sign up'
  end


  test 'fails without an email' do
    click_button 'Sign up'

    assert page.has_selector?("#error_explanation li", text: "Email can't be blank")
  end

  test 'fails without a password' do
    click_button 'Sign up'
    
    assert page.has_selector?("#error_explanation li", text: "Password can't be blank")
  end

  test 'fails with a short password' do
    fill_in :user_password, with: 'abc'

    click_button 'Sign up'
    
    assert page.has_selector?("#error_explanation li", text: "Password is too short (minimum is 6 characters)")
  end

  test 'fails without a password confirmation' do
    fill_in :user_password, with: 'abcd1234'

    click_button 'Sign up'
    
    assert page.has_selector?("#error_explanation li", text: "Password confirmation doesn't match Password")
  end

  test "fails if confirmation password doesn't match the password" do
    fill_in :user_password, with: 'abcd1234'
    fill_in :user_password_confirmation, with: 'password@!'

    click_button 'Sign up'
    
    assert page.has_selector?("#error_explanation li", text: "Password confirmation doesn't match Password")
  end

  test 'fails if the email already exists' do
    visit new_user_registration_path

    fill_in 'user_email', with: 'norah.jones@test.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Sign up'

    assert page.has_selector?("#error_explanation li", text: "Email has already been taken")
  end

  test 'Can sign up' do
    register_with('admin@test.com', 'password')

    assert page.has_content?("Welcome! You have signed up successfully.")
  end
end
