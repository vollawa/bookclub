class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @books = Book.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
  end

  def show
  end

  def new
    @book = current_user.books.build
  end

   def edit
  end

   def create
    @book = current_user.books.build(book_params)

      if @book.save
       redirect_to @book, notice: 'Book was successfully created.' 
       else
        render action: 'new' 
      end
  end

   def update
      if @book.update(book_params)
       redirect_to @book, notice: 'Book was successfully updated.' 
      else
       render action: 'edit' 
      end
    end

  def destroy
    @book.destroy
     redirect_to books_url 
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def correct_user
      @book = current_user.books.find_by(id: params[:id])
      redirect_to books_path, notice: "Not authorized to edit this book" unless @book.user == current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:description, :image)
    end
end
