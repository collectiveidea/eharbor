require 'spec_helper'

describe "users/show" do
  before do
     @user = Factory(:user)  
     @listing = Factory(:listing, :user => @user)    
     assigns[:user] = @user    
   end
   
   it "should link to the listing" do  
     render
     response.should have_tag("a[href=?]", listing_path(@listing))
   end
   
   it "should not show the profile edit link" do  
     render
     response.should_not have_tag("a[href=?]", edit_profile_path)
   end   
   
   context 'when signed in' do     
     before do 
       sign_in_as @user   
       render
     end
     it "should show the profile edit link" do 
       response.should have_tag("a[href=?]", edit_profile_path)
     end
   end
end