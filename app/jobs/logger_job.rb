# class LoggerJob < ApplicationJob
#   queue_as :default
#
#   def perform(name)
#     Rails.logger.info("Hello from LoggerJob! My name is: #{name}!")
#   end
# end


# frozen_string_literal: true

class LoggerJob
  include Sidekiq::Job

  def perform(name)
    Rails.logger.info("Hello from LoggerJob! My name is: #{name}!")
  end
end