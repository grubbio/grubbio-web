When /^(?:|I )log in as a (.*)?$/ do |user_role|
  email = "#{user_role}@grubb.io"
  password = 'password'
  #User.new(:email => email, :password => password, :password_confirmation => password).save!

  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Sign in"
end