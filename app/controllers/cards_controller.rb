class CardsController < ApplicationController
  def update
    customer = Stripe::Customer.retrieve(current_user.stripe_id)

    subscription = customer.subscriptions.retrieve(current_user.stripe_subscription_id)
    subscription.source  = params[:stripeToken]
    subscription.save

    current_user.update(
      card_last4: params[:card_last4],
      card_exp_month: params[:card_exp_month],
      card_exp_year: params[:card_exp_year],
      card_type: params[:card_type]
    )

    redirect_to edit_subscription_path, notice: "Successfully updated your card"
  end
end
