require 'rails_helper'

describe ChargesController do 
  describe 'new' do

    it "prohibits non-users" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
    
    it "loads the correct data into the stripe variable" do
      Rails.configuration.stripe[:publishable_key] = 'WhateverIWant'

      user = create(:user)
      sign_in user
      get :new
      expect( assigns(:stripe_btn_data) ).to eq({ key: "WhateverIWant", description: "BigMoney Membership - #{user.email}" })
    end
  end

  describe 'create' do
    it "prohibits non-users" do
      post :create
      expect(response).to redirect_to(new_user_session_path)
    end

    it "marks a user as paid" do
      allow(Stripe::Customer).to receive(:create).and_return( double(id: 'whatever') )
      allow(Stripe::Charge).to receive(:create).and_return(true)
      user = create(:user)
      expect(user).not_to be_paid
      sign_in user

      post :create
      expect(user.reload).to be_paid
    end
  end
end