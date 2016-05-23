require 'test_helper'
require 'stripe_mock'

class CardsControllerTest < ActionController::TestCase
  def stripe_helper
    StripeMock.create_test_helper
  end

  setup do
    StripeMock.start
    stripe_helper.create_plan(id: 'monthly', amount: 10)
    card_token = stripe_helper.generate_card_token
    customer = Stripe::Customer.create(source: card_token)
    subscription = customer.subscriptions.create(
        source: card_token,
        plan: "monthly"
    )
    @user = users(:subscribed)
    @user.stripe_id = customer.id
    @user.stripe_subscription_id = subscription.id
    @user.save
    @user_id = @user.id
    sign_in @user
  end

  teardown do
    StripeMock.stop
  end

  test "should update Card" do
    card_token = stripe_helper.generate_card_token
    assert_equal("4444", User.find(@user_id).card_last4)
    patch :update, { stripeToken: card_token, card_last4: "5555", card_exp_month: "02", card_exp_year: "84", card_type: "Mastercard"}
    assert_equal("5555", User.find(@user_id).card_last4)
    assert_redirected_to edit_subscription_path
  end
end
