class CollaboratorsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :load_wiki
  before_action :block_non_owner
  before_action :block_non_paying

  def index
    @collabs = @wiki.collaborations
    @non_collabs = User.where.not(id: @collabs.pluck(:user_id))
  end

  private

  def load_wiki
    @wiki = Wiki.friendly.find(params[:wiki_id])
  end

  def block_non_owner
    if !current_user.owns?(@wiki)
      flash[:error] = "That's not your wiki!"
      redirect_to owned_wikis_user_path(current_user)
    end
  end

  def block_non_paying
    if !current_user.paid?
      flash[:error] = "Only paid users can add collaborators!"
      redirect_to new_charge_path
    end
  end
end
