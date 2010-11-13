Given "I am signed in" do
  user = Factory(:user, :password => 'secret')
  
  Given 'I go to the homepage'
  And 'I follow "Sign In"'
  And %Q{I fill in "user_email" with "#{user.email}"}
  And 'I fill in "user_password" with "secret"'
  And 'I press "Sign in"'
end