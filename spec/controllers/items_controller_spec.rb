# frozen_string_literal: true

RSpec.describe ItemsController do
  let(:user) { create(:user) }
  let(:item) { create(:item, user: user) }
  let(:item1) { create(:item, user: user) }


  describe '#show' do
    subject { get :show, params: {
      user_id: user.id,
      uuid: item.uuid,
    } }

    it 'returns ok status' do
      expect(subject).to have_http_status(:ok)
    end

    it 'returns item data' do
      subject

      parsed_response = JSON.parse(response.body)

      expect(parsed_response['uuid']).to eq(item.uuid)
      expect(parsed_response['price'].to_f).to eq(item.price.to_f)
      expect(parsed_response['brand']).to eq(item.brand)
      expect(parsed_response['photo_url']).to eq(item.photo_url)
      expect(parsed_response['user_id']).to eq(item.user_id)
    end
  end

  describe '#update' do
    subject { patch :update, params: {
      user_id: user.id,
      uuid: item.uuid,
      item: {
        price: 1.24,
        brand: "nike",
        photo_url: 'url'
      }
    } }

    it 'returns ok status' do
      expect(subject).to have_http_status(:ok)
    end

    it 'updates item data' do
      subject

      item.reload

      parsed_response = JSON.parse(response.body)

      expect(parsed_response['price'].to_f).to eq(item.price.to_f)
      expect(parsed_response['brand']).to eq(item.brand)
      expect(parsed_response['photo_url']).to eq(item.photo_url)
    end
  end

  describe '#create' do
    subject { post :create, params: {
      user_id: user.id,
      price: 2.29,
      brand: 'carhartt',
      photo_url: "url"
    } }

    it 'returns ok status' do
      expect(subject).to have_http_status(:created)
    end

    it 'creates item data' do
      subject

      parsed_response = JSON.parse(response.body)

      expect(parsed_response['price'].to_f).to eq(2.29)
      expect(parsed_response['brand']).to eq('carhartt')
      expect(parsed_response['photo_url']).to eq("url")
      expect(parsed_response['user_id']).to eq(user.id)
    end
  end

  describe '#destroy' do
    subject { delete :destroy, params: {
      user_id: user.id,
      uuid: item.uuid,
    } }

    it 'returns ok status' do
      expect(subject).to have_http_status(:ok)
    end

    it 'destroys item data' do
      subject

      parsed_response = JSON.parse(response.body)

      expect(parsed_response['uuid']).to eq(item.uuid)
      expect(parsed_response['price'].to_f).to eq(item.price.to_f)
      expect(parsed_response['brand']).to eq(item.brand)
      expect(parsed_response['photo_url']).to eq(item.photo_url)
      expect(parsed_response['user_id']).to eq(item.user_id)
    end
  end

  describe '#index' do
    subject { get :index, params: { user_id: user.id, page: 1 } }

    before do
      item
      item1
    end

    it 'returns ok status' do
      expect(subject).to have_http_status(:ok)
    end

    it 'returns all items' do
      subject

      parsed_response = JSON.parse(response.body)
      items_data = parsed_response["items"]

      expect(items_data.length).to eq(2)

      expect(items_data.map { |sent_item| sent_item["uuid"] }).to include(item1.uuid, item.uuid)
      expect(items_data.map { |sent_item| sent_item["price"] }).to include(item1.price.to_s, item.price.to_s)
      expect(items_data.map { |sent_item| sent_item["brand"] }).to include(item1.brand, item.brand)
      expect(items_data.map { |sent_item| sent_item["photo_url"] }).to include(item1.photo_url, item.photo_url)
      expect(items_data.map { |sent_item| sent_item["user_id"] }).to all(eq(user.id))
    end
  end
end
