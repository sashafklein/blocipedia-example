require 'rails_helper'

describe Collaboration do 

  include Devise::TestHelpers
  
  describe "creation" do

    before do
      @user = create(:user)
      @wiki = create(:wiki)
    end

    it "can be created directly" do
      expect(@wiki.collaborators).to eq []
      Collaboration.create(wiki: @wiki, collaborator: @user)
      expect(@wiki.reload.collaborators).to eq [@user]
    end

    it "can be created indirectly" do
      expect(@wiki.collaborators).to eq []
      expect(Collaboration.count).to eq 0

      @wiki.collaborators << @user
      expect(@wiki.collaborators).to eq [@user]
      expect(Collaboration.first.collaborator).to eq @user
      expect(Collaboration.first.wiki).to eq @wiki
    end
  end
end