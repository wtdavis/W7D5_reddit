class UsersController < ApplicationController

    def index
        @users = User.all
        render :index
    end

    def show
        @user = User.find_by(id: params[:id])
        if @user
            render :show
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to users_url
        end
    end

    def new
        @user = User.new
        render :new
    end

    def create  
        @user = User.new(user_params)
        if @user.save
            login!(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end

    end

    def destroy
        if current_user == User.find(params[:id])
            current_user.logout!
            User.destroy(params[:id])
        else
            redirect_to users_url
        end
    end



    private
    def user_params
        params.require(:user).permit(:username, :password)
    end

end
