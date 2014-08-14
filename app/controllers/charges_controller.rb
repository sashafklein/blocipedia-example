class ChargesController < ApplicationController
 
  before_action :authenticate_user!
  
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
    }
  end 

  def create
    @amount = 10_00

    customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
     customer: customer.id,
     amount: @amount,
     description: "BigMoney Membership - #{current_user.email}",
     currency: 'usd'
    )

    current_user.update_attribute(:paid, true)
    
    flash[:success] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to owned_wikis_user_path(current_user)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end