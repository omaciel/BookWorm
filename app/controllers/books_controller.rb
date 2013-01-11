class BooksController < ApplicationController
    before_filter :authenticate, :only => [:new, :create, :destroy, :edit, :update]

    def new
        @book = Book.new
    end

    def create
        @book = current_user.books.build(params[:book])
        if @book.save
            flash[:success] = "Book was successfully created.!"
        end

        redirect_to user_path(current_user)
    end

    def show
        @book = Book.find(params[:id])
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])

        if @book.update_attributes(params[:book])
            flash[:success] = "Book updated."
            redirect_to user_path(current_user)
        else
            render :edit
        end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy

        respond_to do |format|
            format.html { redirect_to user_path(current_user) }
            format.json { head :ok }
        end
    end

end
