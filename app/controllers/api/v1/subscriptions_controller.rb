class Api::V1::SubscriptionsController < ApplicationController
  def create
    test = Subscription.new(subscription_params)
    if test.save
      render json: SubscriptionSerializer.new(test), status: 201
    else
      render json: { errors: { details: "Please enter all information" } }, status: 400
    end
  end

  def update
    updated_sub = Subscription.find_by(id: params[:id])
    updated_sub.update(subscription_params)
    render json: SubscriptionSerializer.new(updated_sub), status: 201
  end

  def index
    if Customer.where(id: params[:customer_id]).empty?
      render json: { errors: { details: "Sorry, that user does not exist" } }, status: 400
    else
      render json: SubscriptionSerializer.new(Subscription.all.where("customer_id = ?", params[:customer_id]))
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
  end
end