# frozen_string_literal: true

RSpec.describe ItemsController do
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:item_uuid) { item.uuid }
  let(:item) { create(:item, user: user) }
  let(:item1) { create(:item, user: user) }

  shared_examples 'user does not exist' do
    context "when user does not exist" do
      let(:user_id) { -1 }

      it 'returns error code if the user was not found' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
        # expect(subject).to have_http_status(:not_found)
      end
    end
  end

  shared_examples 'item does not exist' do
    context 'when item does not exist' do
      let(:item_uuid) { 'non-existent-uuid' }

      it 'returns error code if the item was not found' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#show' do
    subject { get :show, params: {
      user_id: user_id,
      uuid: item_uuid,
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

    include_examples 'user does not exist'
    include_examples 'item does not exist'
  end

  describe '#update' do
    subject { patch :update, params: {
      user_id: user_id,
      uuid: item_uuid,
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

    include_examples 'user does not exist'
    include_examples 'item does not exist'
  end

  describe '#create' do
    subject { post :create, params: {
      user_id: user_id,
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
      expect(parsed_response['user_id']).to eq(user_id)
    end
  end

  describe '#destroy' do
    subject { delete :destroy, params: {
      user_id: user_id,
      uuid: item_uuid,
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
    subject { get :index, params: { user_id: user_id, page: 1 } }

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

    include_examples 'user does not exist'
  end
end
