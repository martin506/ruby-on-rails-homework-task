# frozen_string_literal: true

class User < ApplicationRecord
  has_many :items, dependent: :destroy

  before_create :set_uuid

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end