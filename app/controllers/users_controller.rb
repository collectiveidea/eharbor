class UsersController < Clearance::UsersController

  def show
    @user = User.find(params[:id])
  end
  
end