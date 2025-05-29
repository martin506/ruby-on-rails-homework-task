# frozen_string_literal: true

class User < ApplicationRecord
  before_create :set_uuid

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end