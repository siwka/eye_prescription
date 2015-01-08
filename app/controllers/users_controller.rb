class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @prescriptions = @user.prescriptions.paginate(page: params[:page], per_page: 4)    
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user          
      flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
   	end  
end
