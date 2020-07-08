class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    if params[:id].present?
      @books = Author.find(params[:id]).books.uniq
    else
       @books = Book.all
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
    @authors = Array.new
    # render json: @authors 
    # return
    # @book.authors.each do |author|
    #   @authors<<author[:id]
    # end
    # @authors = @authors.uniq
  end

  # GET /books/1/edit
  def edit
    @authors = []
    @book.authors.each do |author|
      @authors<<author[:id]
    end
    @authors = @authors.uniq
    # render json: @authors.uniq
    # return
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    # params[:author_ids].select{ |i| i.present? }.to_a.each do |author_id|
    #   AuthorsBook.create(author_id:author_id,book_id:@book.id)
    # end

    respond_to do |format|
      if @book.save
        unless book_params[:author_ids].nil?
          book_params[:author_ids].reject { |e| e.to_s.empty? }.to_a.each do |author_id|
            AuthorsBook.create(author_id:author_id,book_id:@book.id)
          end
        end
        format.html { redirect_to @book, notice: 'Book was successfully created.' }

      else
        format.html { render :new }
      end
    end

    # render json: book_params[:author_ids].select{ |i| i.present? }
    # return
    
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        @book.authors.delete_all
        book_params[:author_ids].reject { |e| e.to_s.empty? }.to_a.each do |author_id|
          AuthorsBook.create(author_id:author_id,book_id:@book.id)
        end
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title,author_ids:[])
    end
end
