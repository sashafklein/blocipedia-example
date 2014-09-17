class CollaborationsController < ApplicationController

  before_action :authenticate_user!

  before_action :load_wiki
  before_action :authorize_current_user!
  before_action :load_user
  before_action :load_collab

  def create
    if @collab.persisted?
      flash[:error] = "That user's already a collaborator on this wiki!"
    else
      @collab.save!
      flash[:success] = "Collaborator added!"
    end

    redirect_to wiki_collaborators_path(@wiki)
  end

  def destroy
    if @collab.persisted?
      @collab.destroy
      flash[:success] = "Collaborator removed."
    else
      flash[:error] = "That user isn't a collaborator and can't be removed!"
    end
    
    redirect_to wiki_collaborators_path(@wiki)
  end

  private

  def load_wiki
    @wiki = Wiki.friendly.find(params[:wiki_id])
  end

  def authorize_current_user!
    unless current_user == @wiki.owner
      permission_error
    end
  end
  def load_user
    @user = User.find(params[:user_id])
  end

  def load_collab
    @collab = Collaboration.where(collaborator: @user, wiki: @wiki).first_or_initialize
  end
end