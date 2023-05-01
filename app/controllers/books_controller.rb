class BooksController < ApplicationController
  before_action :ensure_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

   def index
        # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @user=current_user
    @book = Book.new
    @books = Book.all
    

   end
  # 以下を追加
  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    @book.user_id =current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @book=Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to  books_path
    end
  end

  def update
  @book = Book.find(params[:id])
  if @book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
  else
    flash.now[:alert] = @book.errors.full_messages.join(', ')
    render :edit
  end
  end


  def destroy
  @book = Book.find(params[:id])
  @book.destroy
  redirect_to books_path
  end

private
def ensure_user
    @books = current_user.books
    @book = @books.find_by(id: params[:id])
    redirect_to books_path unless @book
end
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end