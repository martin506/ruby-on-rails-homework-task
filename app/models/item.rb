# frozen_string_literal: true

class Item < ApplicationRecord
  enum :status, sold: 0, active: 1
  before_create :set_uuid

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end