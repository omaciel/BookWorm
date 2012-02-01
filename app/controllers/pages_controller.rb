class PagesController < ApplicationController

    def home
        @title = "Home"
        if signed_in?
            @user = current_user
            @books = @user.books.paginate(:page => params[:page])
        end
    end

    def contact
        @title = "Contact"
    end

    def about
        @title = "About"
    end

end
