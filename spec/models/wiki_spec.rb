require 'rails_helper'

describe Wiki do 
  describe "user association methods" do

    before do
      @owner = create(:user)
      @collaborator = create(:user)
      @wiki = create(:wiki, owner: @owner)
      Collaboration.create(wiki: @wiki, collaborator: @collaborator)
    end

    describe "owner" do
      it "returns the wiki's owner" do
        expect(@wiki.owner).to eq @owner
      end
    end

    describe "collaborators" do
      it "returns a collection of collaborating users" do
        expect(@wiki.collaborators).to eq [@collaborator]
      end
    end

    describe "non_collaborators" do
      
      before { @other_user = create(:user) }

      it "returns users who aren't collaborators or owners" do
        expect(@wiki.non_collaborators).to eq([@other_user])
      end
    end
  end
end