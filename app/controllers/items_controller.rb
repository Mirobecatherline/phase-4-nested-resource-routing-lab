class ItemsController < ApplicationController
  
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def index
    if params[:user_id]
      user= User.find(params[:user_id])
      items=user.items
    else
      items=Item.all
    end
    render json: items, include: :user
  end
  def show
    items=Item.find(params[:user_id])
    render json: items, include: :user
  end
  def create
      items= Item.create(item_params)
      render json: items,status: :created
  end
  private
  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end
end
