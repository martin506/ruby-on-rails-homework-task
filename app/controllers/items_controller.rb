class ItemsController < ApplicationController
  def show
    @item = Item.find_by!({ uuid: params[:uuid], user_id: params[:user_id] })

    render json: @item
  end

  def create
    @item = Item.create!(
      user_id: params[:user_id].to_i,
      price: params[:price],
      brand: params[:brand],
      photo_url: params[:photo_url],
      status: 1,
    )

    if @item.persisted?
      render json: @item, status: :created
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find_by!({ uuid: params[:uuid], user_id: params[:user_id] })

    @item.destroy

    render json: @item
  end

  def update
    @item = Item.find_by!({ uuid: params[:uuid], user_id: params[:user_id] })
    @item.update!(item_params)

    render json: @item
  end

  def index
    @items = Item.all.where({user_id: params[:user_id]}).order(created_at: :desc).page(params[:page])

    render json: {items: @items}
  end

  def item_params
    params.require(:item).permit(:price, :brand, :photo_url, :status, :user_id)
  end
end