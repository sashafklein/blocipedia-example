require 'rails_helper'

describe CollaborationsController do

  before do 
    @user = create(:user)
    @wiki = create(:wiki, owner: @user)
    @collaborator = create(:user)
    sign_in @user
  end

  describe "create" do

    context "signed in as wrong user" do
      it "blocks the user" do
        @wiki.update_attribute(:owner_id, @collaborator.id)
        post :create, user_id: @user.id, wiki_id: @wiki.id
        expect(response).to redirect_to root_path
        expect(flash[:error]).to eq("You don't have permission to do that.")
      end
    end

    context "without existing collaboration" do
      it "creates a collaboration and flashes success" do
        count = Collaboration.count
        post :create, user_id: @collaborator.id, wiki_id: @wiki.id
        expect( Collaboration.count ).to eq(count + 1)
        expect(flash[:success]).to eq("Collaborator added!")
      end
    end

    context "with existing collaboration" do
      it "doesn't create a collaborator, and flashes error" do
        Collaboration.create(collaborator: @collaborator, wiki: @wiki)
        count = Collaboration.count

        post :create, user_id: @collaborator.id, wiki_id: @wiki.id
        
        expect(Collaboration.count).to eq(count)
        expect(flash[:error]).to eq("That user's already a collaborator on this wiki!")
      end
    end
  end

  describe "destroy" do
    before { @collaboration = @wiki.collaborations.create(collaborator: @collaborator) }

    context "signed in as wrong user" do
      it "blocks the user" do
        @wiki.update_attribute(:owner_id, @collaborator.id)
        delete :destroy, user_id: @collaborator.id, wiki_id: @wiki.id, id: @collaboration.id
        expect(response).to redirect_to root_path
        expect(flash[:error]).to eq("You don't have permission to do that.")
      end
    end

    context "signed in correctly" do
      it "deletes the collaboration" do
        count = Collaboration.count
        delete :destroy, user_id: @collaborator.id, wiki_id: @wiki.id, id: @collaboration.id

        expect( Collaboration.count ).to eq(count - 1)
        expect(flash[:success]).to eq("Collaborator removed.")
      end
    end

  end

end