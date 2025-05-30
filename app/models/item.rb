# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :user

  max_paginates_per 5

  enum :status, sold: 0, active: 1
  before_create :set_uuid

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end