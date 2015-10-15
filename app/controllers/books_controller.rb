class BooksController < ApplicationController
  before_action :set_user
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = @user.books.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = @user.books.build
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = @user.books.create(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to [@user, @book], notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: [@user, @book] }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to [@user, @book], notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: [@user, @book] }
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
      format.html { redirect_to users_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_book
    @book = @user.books.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :user_id)
  end
end