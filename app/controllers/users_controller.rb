class UsersController < ApplicationController
  
  before_action :load_user

  def owned_wikis
    @wikis = current_user.owned_wikis
  end

  def collaborated_wikis
    @wikis = current_user.collaborated_wikis
  end

  private

  def load_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user == @user
  end
end
