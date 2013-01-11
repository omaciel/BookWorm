class PagesController < ApplicationController

    def home
        @title = "Home"
        @books = Book.paginate(:page => params[:page], :per_page => 15, :order => "finished_at DESC, started_at DESC, title ASC").where(:visible => true)
    end

    def contact
        @title = "Contact"
    end

    def about
        @title = "About"
    end

end
