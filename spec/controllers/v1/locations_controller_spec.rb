require 'rails_helper'

describe V1::LocationsController, type: :controller do

  describe 'GET show' do
    let(:location) { V1::Location.new(FactoryGirl.attributes_for(:v1_location)) }

    context 'on success' do
      it 'returns a 200' do
        allow(V1::Location).to receive(:find).with(location.id) { location }
        get :show, id: location.id
        expect(response.status).to eq(200)
      end

      it 'returns the location' do
        allow(V1::Location).to receive(:find).with(location.id) { location }
        get :show, id: location.id
        expect(JSON.parse(response.body)['location']['id']).to eq(location.id)
      end
    end

    context 'on failure' do
      it 'returns a 404' do
        allow(V1::Location).to receive(:find).with(location.id) { nil }
        get :show, id: location.id
        expect(response.status).to eq(404)
      end

      it 'has an error message' do
        allow(V1::Location).to receive(:find).with(location.id) { nil }
        get :show, id: location.id
        expect(JSON.parse(response.body)).to eq({'message' => I18n.t('locations.find.failed')})
      end
    end
  end

  describe 'POST create' do
    context 'on success' do
      it 'saves the location' do
        post :create, location: FactoryGirl.attributes_for(:v1_location)
        expect(response.status).to eq(202)
      end

      it 'responds with an id' do
        post :create, location: FactoryGirl.attributes_for(:v1_location)
        expect(JSON.parse(response.body)['id']).to_not be_blank
      end
    end

    context 'on failure' do
      it 'responds with a 422' do
        allow(V1::Location).to receive(:new) { double("location", save: false) }
        post :create, location: { foo: 'bar' }
        expect(response.status).to eq(422)
      end

      it 'has an error message' do
        allow(V1::Location).to receive(:new) { double("location", save: false) }
        post :create, location: { foo: 'bar' }
        expect(JSON.parse(response.body)).to eq('message' => I18n.t('locations.create.failed'))
      end
    end
  end
end
