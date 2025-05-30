# frozen_string_literal: true

RSpec.describe LoggerJob do
  subject { described_class.new.perform('test') }

  it 'logs a message with the provided name' do
    expect(Rails.logger).to receive(:info).with('Hello from LoggerJob! My name is: test!')

    subject
  end
end
