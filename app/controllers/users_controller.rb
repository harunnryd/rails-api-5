class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    success = -> (user) { render(json: user, status: :created, location: user) }
    failure = -> (user) { render(json: user.errors, status: :unprocessable_entity) }
    @user = User.new(user_params)
    @user.save ? success.call(@user) : failure.call(@user)
  end

  def update
    success = -> (user) { render(json: user) }
    failure = -> (user) { render(json: user.errors, status: :unprocessable_entity) }
    @user.update(user_params) ? success(@user) : failure.call(@user)
  end

  def destroy
    @user.destroy
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password_digest, :admin)
    end
end
