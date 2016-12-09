class MicropostsController < ApplicationController
  before_filter :signed_in_user

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @micropost = Micropost.find_by_id(params[:id])
      redirect_to root_url unless current_user?(@micropost.user)
    end
end