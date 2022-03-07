def register_with(name, email, password)
  visit new_user_registration_path

  fill_in 'Name', with: name
  fill_in 'Email', with: email
  fill_in 'user_password', with: password
  fill_in 'user_password_confirmation', with: password

  click_button 'Sign up'
end


def log_in_with(email, password)
  visit new_user_session_path
  save_and_open_page
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password

  click_button 'Log in' , wait:15
end
