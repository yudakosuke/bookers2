class UsersController < ApplicationController
  before_action :ensure_user, only: [:edit, :update]
  def index
    @user=current_user
    @book = Book.new
    @users = User.all
  end

  def show
    @book_new = Book.new
    @user = User.find(params[:id])
    @books = @user.books
    @title = 'show'
  end

  def edit
    @user = User.find(params[:id])
  end

 def update
  @user = User.find(params[:id])

  if @user.update(user_params)
    flash[:success] = "User updated successfully"
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user)
  else
    flash.now[:error] = @user&.errors&.full_messages&.to_sentence || "An error occurred"
    render 'edit'
  end
 end

   private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_user
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to user_path(current_user)
      end
  end
end
