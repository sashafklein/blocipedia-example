class WikisController < ApplicationController

  before_action :authenticate_user!
  before_action :load_wiki, only: [:show, :edit, :update, :destroy]
  before_action :block_non_owner, only: [:destroy]
  before_action :block_non_editor, only: [:edit, :update]
  before_action :block_private, only: [:show]

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.owned_wikis.new(wiki_params)

    if @wiki.save
      flash[:success] = "Wiki created!"
      redirect_to @wiki
    else
      flash[:error] = "Wiki creation failed."
      redirect_to new_wiki_path
    end
  end

  def show
  end

  def edit
  end

  def update
    if @wiki.update_attributes(wiki_params)
      flash[:success] = "Wiki updated!"
      redirect_to @wiki
    else
      flash[:error] = "Wiki update failed."
      redirect_to @wiki
    end
  end

  def destroy
    if @wiki.destroy
      flash[:success] = "Wiki destroyed."
    else
      flash[:error] = "Wiki destruction failed."
    end
    redirect_to owned_wikis_user_path(current_user)
  end

  private

  def load_wiki
    @wiki = Wiki.friendly.find(params[:id])
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  def block_non_owner
    unless current_user.owns? @wiki
      permission_error
    end
  end

  def block_non_editor
    unless current_user.can_edit? @wiki
      permission_error
    end
  end

  def block_private
    if @wiki.private? && !current_user.paid?
      flash[:error] = "You need to pay to do that!"
      redirect_to new_charge_path
    end
  end
end
