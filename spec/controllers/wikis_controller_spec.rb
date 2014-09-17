require 'rails_helper'

describe WikisController do
  describe 'show' do
    context "private" do
      before do
        @user = create(:user, paid: true)
        @wiki = create(:wiki, private: true)
      end

      it "sends unpaid users to payment" do
        unpaid = create(:user, paid: false)
        sign_in unpaid
        get :show, id: @wiki.id
        expect(response).to redirect_to(new_charge_path)
      end

      it "lets paid users through" do
        paid = create(:user, paid: true)
        sign_in paid
        get :show, id: @wiki.id        
        assert_response 200
      end
    end
  end

  describe "destroy" do
    before do 
      @user = create(:user)
      @wiki = create(:wiki)
    end

    it "blocks non owners" do
      sign_in @user
      delete :destroy, id: @wiki.id
      expect(flash[:error]).to eq("You don't have permission to do that.")
    end
  end
end