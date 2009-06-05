class UsersController < Clearance::UsersController
  before_filter :authenticate, :only => [:edit, :update]
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :edit
    end
  end
  
end