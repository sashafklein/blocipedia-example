require 'rails_helper'

describe "Editing a wiki" do

  include Warden::Test::Helpers
  Warden.test_mode!

  before do 
    @user = create(:user, paid: true)
    @wiki = create(:wiki, owner: @user)
  end

  context "as owner" do
  end

  context "as collaborator" do

    before do 
      @collaborator = create(:user)
      @wiki.collaborations.create(collaborator: @collaborator)
      login_as @collaborator, scope: :user
    end

    it "allows editing, but not collaborator changing" do
      visit wiki_path(@wiki)

      expect(current_path).to eq(wiki_path(@wiki))
      expect(page).to have_content "Edit"
      expect(page).not_to have_content "Edit collaborators"

      click_link "Edit"

      expect(current_path).to eq(edit_wiki_path(@wiki))

      visit wiki_collaborators_path(@wiki)
      expect(current_path).to eq(owned_wikis_user_path(@collaborator))
      expect(page).to have_content "That's not your wiki!"
    end
  end

  context "as regular user" do
  end

  context "not signed in" do
  end
end