# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    price { 1.22 }
    brand { 'balenciaga addias' }
    photo_url { 'basic_url' }
    user_id { 1 }

    association :user
  end
end