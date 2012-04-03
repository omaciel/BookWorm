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
            @title = @user.name
            @books = @user.books.paginate(:page => params[:page], :per_page => 15).order("finished_at DESC, title ASC")
            @total_books = @user.books.count(:conditions => "status = 'Finished'")
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
