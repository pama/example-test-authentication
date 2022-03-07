require "application_system_test_case"
require 'macros/authentication'

class SignsOutTest < ApplicationSystemTestCase
  test 'Logs out' do
    log_in_with('norah.jones@test.com', 'password')

    click_button 'Sign out'

    assert page.has_content? 'You need to sign in or sign up before continuing.'
  end
end
