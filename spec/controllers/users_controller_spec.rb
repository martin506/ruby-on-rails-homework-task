# frozen_string_literal: true

RSpec.describe UsersController do
  describe '#show' do
    subject { get :show, params: { uuid: user.uuid } }

    let(:user) { create(:user) }

    it 'returns ok status' do
      expect(subject).to have_http_status(:ok)
    end

    it 'returns user data' do
      subject

      parsed_response = JSON.parse(response.body)

      expect(parsed_response['uuid']).to eq(user.uuid)
      expect(parsed_response['name']).to eq(user.name)
      expect(parsed_response['email']).to eq(user.email)
    end
  end
end