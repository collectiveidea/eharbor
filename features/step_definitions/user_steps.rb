Given "I am signed in" do
  user = FactoryGirl.create(:user, :password => 'password')
  
  step 'I go to the homepage'
  step 'I follow "Sign In"'
  step %Q{I fill in "user_email" with "#{user.email}"}
  step 'I fill in "user_password" with "secret"'
  step 'I press "Sign in"'
end