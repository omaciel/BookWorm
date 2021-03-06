class UsersController < ApplicationController
    before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
    before_filter :correct_user, :only => [:edit, :update]
    before_filter :admin_user,   :only => :destroy

    def index
        @title = "All users"
        @users = User.paginate(:page => params[:page], :order => 'finished_at DESC', :per_page => 20)
    end

    def show


        if signed_in?
            @user = current_user
            if params[:status].nil? then
                params[:status] = session[:status].nil? ? {} : session[:status]
                @books = Book.paginate(:page => params[:page], :per_page => 15, :conditions => { :user_id => @user }).order("finished_at DESC, title ASC")
            else
                session[:status] = params[:status]
                @books = Book.paginate(:page => params[:page], :per_page => 15, :conditions => { :user_id => @user, :status => params[:status].keys }).order("finished_at DESC, title ASC")
            end
            @title = @user.name

            @all_status = Book.status
            @books_total = @user.books.count
            @books_finished = (@user.books.count(:conditions => "status = 'Finished'") / @books_total.to_f) * 100
            @books_onhold = (@user.books.count(:conditions => "status = 'On Hold'") / @books_total.to_f) * 100
            @books_reading = (@user.books.count(:conditions => "status = 'Reading'") / @books_total.to_f) * 100
            @books_queued = (@user.books.count(:conditions => "status = 'Queued'") / @books_total.to_f) * 100
            @total_pages = @user.books.calculate(:sum, :pages, :conditions => "status = 'Finished'")
        else
            @title = "Sign up"
            render :new
        end
    end

    def new
        @user = User.new
        @title = "Sign up"
    end

    def create
        @user = User.new(params[:user])
        if @user.save
            # Handle a successful save.
            sign_in @user
            flash[:success] = "Welcome #{@user.name}!"
            redirect_to @user
        else
            @title = "Sign up"
            render :new
        end
    end

    def edit
        @title = "Edit user"
    end

    def update
        if @user.update_attributes(params[:user])
            flash[:success] = "Profile updated."
            redirect_to @user
        else
            @title = "Edit user"
            render :edit
        end
    end

    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "User destroyed."
        redirect_to users_path
    end

    private

    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
        @user = User.find(params[:id])
        redirect_to(root_path) if !current_user.admin? || current_user?(@user)
    end
end
