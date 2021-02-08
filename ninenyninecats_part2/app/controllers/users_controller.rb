class UsersController < ApplicationController

    def new 
        @user = User.new
        render :new
    end 

    def show
        @user = User.find_by(id: params[:id])
        if @user
            render :show
        else
            render json: @user.errors.full_messages, status: 422
        end
    end

    def create 
        @user = User.new(user_params)
        if @user.save 
            login!(@user)
            redirect_to user_url(@user)
        else
            render json: @user.errors.full_messages, status: 422
        end 
    end 

    def user_params
        self.params.require(:user).permit(:user_name, :password)
    end 
end
