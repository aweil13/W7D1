class UsersController < ApplicationController
    before_action :require_logged_out, only: [:new, :create]
    before_action :require_logged_in, only: [:index, :show]

    def new 
        @user = User.new
        render :new
    end 

    
    def create 
        @user = User.new(user_params)
        login_user!(@user)
        # if @user.save 
        #     login!(@user)
        #     redirect_to cats_url
        # else
        #     render json: @user.errors.full_messages, status: 422
        # end 
    end 

    def user_params
        self.params.require(:user).permit(:user_name, :password)
    end 
end
