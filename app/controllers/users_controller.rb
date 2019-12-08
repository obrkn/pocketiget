class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    
    @microposts = Micropost.search(params[:search]).order(id: :desc).page(params[:page])
  end

  def show
    @microposts = current_user.microposts.search(params[:search]).order(id: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def likes
    @microposts = current_user.favorite_microposts.search(params[:search]).page(params[:page])
  end
  
   private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end