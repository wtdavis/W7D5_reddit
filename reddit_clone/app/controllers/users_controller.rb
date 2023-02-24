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

    def 

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end

end
