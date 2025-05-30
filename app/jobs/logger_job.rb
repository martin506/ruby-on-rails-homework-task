# using ActiveJob from rails, read something about ActiveJob
# use then: arguments can be more flexible, can pass ruby structures

# class LoggerJob < ApplicationJob
#   queue_as :default
#
#   def perform(name)
#     Rails.logger.info("Hello from LoggerJob! My name is: #{name}!")
#   end
# end


# frozen_string_literal: true

# using sidekick: quicker, jobs performed directly, use then the jobs
# are needed to be performed really fast, better retry logic

class LoggerJob
  include Sidekiq::Job

  def perform(name)
    Rails.logger.info("Hello from LoggerJob! My name is: #{name}!")
  end
end