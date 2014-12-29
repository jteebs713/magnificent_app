class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.password = params[:password]
		if @user.save
			flash[:notice] = "Thank you for signing up! You are Magnificent!"
			redirect_to posts_path
		else
			render "new"
		end
	end

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			redirect_to user_path(@user)
		else
			render :edit
		end
	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			redirect_to users_path
		else
			redirect_to user_path(@user)
		end
	end	

	private

	def user_params
		params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_hash, :category, :bio, :contact_info)
	end

end












