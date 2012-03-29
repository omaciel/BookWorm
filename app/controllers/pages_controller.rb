class PagesController < ApplicationController

    def home
        @title = "Home"
        if signed_in?
            @user = current_user
            @books = @user.books.paginate(:page => params[:page])
            @total_books = @user.books.count(:conditions => "status = 'Finished'")
            @total_pages = @user.books.calculate(:sum, :pages, :conditions => "status = 'Finished'")
        end
    end

    def contact
        @title = "Contact"
    end

    def about
        @title = "About"
    end

end
