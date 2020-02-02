class MicropostsController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :new, :create, :edit, :update, :destroy ]
  before_action :set_microposts, only: [:show, :edit, :update, :destroy ]
  before_action :correct_user, only: [:edit, :update, :destroy ]
  
  def show
  end
  
  def new
      @micropost = current_user.microposts.build  # form_with 用
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = '投稿しました'
      redirect_to users_path(current_user)
    else
      flash.now[:danger] = '投稿されませんでした'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @micropost.update(micropost_params)
      flash[:success] = '正常に更新されました'
      redirect_to users_path(current_user)
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end

  def destroy
    @micropost.destroy

    flash[:success] = '正常に削除されました'
    redirect_to users_path(current_user)
  end
  
  private
  
  def set_microposts
    @micropost = Micropost.find(params[:id])
  end

  def micropost_params
    params.require(:micropost).permit(:spot, :comment, :latitude, :longitude)
  end
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end
end
