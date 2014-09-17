require 'rails_helper'

describe "creating a wiki" do

  include Warden::Test::Helpers
  Warden.test_mode!

  context "signed in as owner" do

    before do 
      @user = FactoryGirl.create(:user, paid: true)
      @wiki = create(:wiki, owner: @user)

      [1,2].each { |n| create(:user, email: "fake#{n}@fake.com") }
      login_as(@user, scope: :user)
    end

    context "paid" do
      it "lets the user add and remove collaborators" do
        visit wiki_collaborators_path(@wiki)

        expect(page).to have_content "Add fake1@fake.com as collaborator"
        expect(page).to have_content "Add fake2@fake.com as collaborator"

        click_link "Add fake1@fake.com as collaborator"

        expect(page).not_to have_content "Add fake1@fake.com as collaborator"
        expect(page).to have_content "Add fake2@fake.com as collaborator"
        expect(page).to have_content "Remove fake1@fake.com as collaborator"

        click_link "Remove fake1@fake.com as collaborator"

        expect(page).to have_content "Add fake1@fake.com as collaborator"
        expect(page).to have_content "Add fake2@fake.com as collaborator"
      end
    end

    context "unpaid" do
      
      before { @user.update_attribute(:paid, false) }

      it "redirects to payment path" do
        visit wiki_collaborators_path(@wiki)
        expect(current_path).to eq(new_charge_path)
      end
    end
  end

  context "signed in as other user" do
    before do 
      @user = FactoryGirl.create(:user, paid: true)
      @wiki = create(:wiki, owner: @user)

      [1,2].each { |n| @user2 = create(:user, email: "fake#{n}@fake.com", paid: true) }
      login_as(@user2, scope: :user)
    end

    it "lets the user add and remove collaborators" do
      visit wiki_collaborators_path(@wiki)
      expect(current_path).to eq owned_wikis_user_path(@user2)
      expect(page).to have_content "That's not your wiki!"
    end
  end
end