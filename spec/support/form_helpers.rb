module FormHelpers
  def signup_helper(first_name, last_name, email, password)
    visit new_user_path
    within("#new_user") do
      fill_in "First Name", with: first_name
      fill_in "Last Name", with: last_name
      fill_in "Email", with: email
      fill_in "Password", with: password
    end
    submit_form
  end

  def signin_helper(email, password)
    within("#signin-user-form") do
      fill_in "Email", with: email
      fill_in "Password", with: password
    end
    submit_form
  end

  def submit_form
    find('input[name="commit"]').click
  end
end
