require 'rails_helper'

describe "creating a wiki" do

  include Warden::Test::Helpers
  Warden.test_mode!

  context "signed in" do

    before do 
      @user = FactoryGirl.create(:user, paid: true)
      login_as(@user, scope: :user)
    end

    context "paid" do
      it "allows private wikis" do
        visit new_wiki_path
        fill_in 'Title', with: "How's this for a wiki title?"
        fill_in 'Body', with: "Yeah. I know this is a short body."
        
        expect( page ).to have_content "Private"
        check("Private")
        click_button "Create Wiki"

        expect(current_path).to eq wiki_path('how-s-this-for-a-wiki-title')
      end
    end

    context "unpaid" do
      it "doesn't allow private wikis" do
        @user.update_attribute(:paid, false)

        visit new_wiki_path
        fill_in 'Title', with: "How's that for a wiki title?"
        fill_in 'Body', with: "Yeah. I know this is a short body."
        
        expect( page ).not_to have_content "Private"
        click_button "Create Wiki"

        expect(current_path).to eq wiki_path('how-s-that-for-a-wiki-title')
      end
    end
  end

  context "not signed in" do
    it "redirects you to sign in" do
      visit new_wiki_path
      expect(current_path).to eq '/users/sign_in'

      expect(page).to have_content "You need to sign in or sign up before continuing."
    end
  end
end