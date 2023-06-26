class BooksController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update]

  # 投稿データの保存
def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
    flash[:notice] = "book was successfully created."
    redirect_to book_path(@book.id)
  else
    @books = Book.all
    @user = current_user
    render :index #renderはアクションを仲介せずにビューファイルを表示してくれるので、今回renderで定義したindexの定義をelseでも記述しなければならない
  end
end


  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if@book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
  else
    flash[:alert] = "Book not updated due to an error."
    render :edit
  end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end

def is_matching_login_user
    @book = Book.find(params[:id])
    user = User.find(@book.user_id)
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
end
