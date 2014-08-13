require 'rails_helper'

describe User do 
  describe "wiki association methods" do

    before do
      @owner = create(:user)
      2.times { create(:wiki, owner: @owner) }
      @collaborator = create(:user)
      Wiki.find_each do |wiki|
        Collaboration.create(wiki: wiki, collaborator: @collaborator)
      end
    end

    describe "owned_wikis" do
      it "returns all wikis owned by a given user" do
        expect(@owner.owned_wikis).to eq Wiki.all
        expect(@collaborator.owned_wikis).to eq []
      end
    end

    describe "collaborated_wikis" do
      it "returns all wikis on which the user is a collaborator" do
        expect(@owner.collaborated_wikis).to eq []
        expect(@collaborator.collaborated_wikis).to eq Wiki.all
      end
    end
  end
end