class BooksController < ApplicationController
    before_action :authenticate_user!

   def new
    @book = Book.new
   end

   def index
    @books = Book.all
    @user = User.find(current_user.id)
    @book = Book.new
   end

   def edit
    @book = Book.find(params[:id])
    if current_user.id != @book.user_id
       redirect_to books_path
    end
   end

   def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "Book was successfully updated."
    redirect_to book_path(@book.id)
    else
    render "edit"
    end
   end

   def show
    @book = Book.new
    @user = User.find(current_user.id)
    @show_book = Book.find(params[:id])
    @book_comment = BookComment.new
   end

   def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "successfully"
       redirect_to books_path
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render :index
    end
   end

   private
   def book_params
       params.require(:book).permit(:title, :body)
   end
end
