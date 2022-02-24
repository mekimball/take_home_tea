class Api::V1::SubscriptionsController < ApplicationController
  def create
    render json: SubscriptionSerializer.new(Subscription.create(subscription_params)), status: 201
  end

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
  end
end