class Api::V1::SubscriptionsController < ApplicationController
  def create
    render json: SubscriptionSerializer.new(Subscription.create(subscription_params)), status: 201
  end

  def update
    updated_sub = Subscription.find_by(id: params[:id])
    updated_sub.update(subscription_params)
    render json: SubscriptionSerializer.new(updated_sub), status: 201
  end

  def index
    render json: SubscriptionSerializer.new(Subscription.all.where("customer_id = ?", params[:customer_id]))
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
  end
end