require_relative 'gilt'

class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authorize, only: [:edit, :update, :destroy]
	

	def index
		@posts = Post.all.order(created_at: :desc)
		@gilt = Gilt.new(ENV['GILT_KEY'])
	end

	def show
		@post = Post.find(params[:id])
		@random_post = Post.random(@post)
	end

	def new
		@post = current_user.posts.new
	end

	def create
		@post = current_user.posts.new(post_params)

		if @post.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit

	end

	def update
		if @post.update(post_params)
			redirect_to root_path
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	private

	def find_post
		@post = Post.find(params[:id])
  end

	def post_params
		params.require(:post).permit(:title, :link, :description, :user, :image, :post_pic, :category)
	end

	def authorize
		if current_user.admin != true
			redirect_to @post
		end
	end
end
