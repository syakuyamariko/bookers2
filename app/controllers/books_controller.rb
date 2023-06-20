class BooksController < ApplicationController


  # 投稿データの保存
def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
    flash[:notice] = "book was successfully created."
    redirect_to books_path(book.id)
  else
    flash[:alert] = "error book was not created."
    render :new
  end
end


  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
    redirect_to books_path
    else
      @books = Book.all
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

end
