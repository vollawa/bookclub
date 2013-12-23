class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
  end

   def edit
  end

   def create
    @book = Book.new(book_params)

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

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:description)
    end
end
