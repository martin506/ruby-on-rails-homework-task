class ItemSerializer < ActiveModel::Serializer
  attributes :uuid, :price, :brand, :photo_url, :user_id
end
