class WikisController < ApplicationController

  before_action :load_wiki, only: [:show, :edit, :update, :destroy]
  
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
    redirect_to user_wikis_path(current_user)
  end

  private

  def load_wiki
    @wiki = Wiki.friendly.find(params[:id])
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end
end
