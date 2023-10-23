require 'rails_helper'

RSpec.describe '/tracks', type: :request do
  let!(:conference) { create(:conference) }
  let!(:tracks) { create_list(:track, 10, conference: conference) }
  let(:track_id) { tracks.first.id }

  describe 'GET /tracks' do
    before { get '/tracks' }

    it 'returns tracks' do
      expect(json.size).to eq(12) # 2 from conference creation
    end

    it_behaves_like 'http status code', 200
  end

  describe 'GET /tracks/:id' do
    before { get "/tracks/#{track_id}" }

    context 'when the record exists' do
      it 'returns the track' do
        expect(json['id']).to eq(track_id)
      end

      it_behaves_like 'http status code', 200
    end

    context 'when the record does not exist' do
      let(:track_id) { 100 }

      it_behaves_like 'http status code', 404
    end
  end

  describe 'POST /tracks' do
    let(:valid_attributes) { { identifier: 'A', conference_id: conference.id } }
    let(:invalid_attributes) { { identifier: nil } }

    context 'when the request is valid' do
      before { post '/tracks', params: { track: valid_attributes } }

      it 'creates a track' do
        expect(json['identifier']).to eq('A')
      end

      it_behaves_like 'http status code', 201
    end

    context 'when the request is invalid' do
      before { post '/tracks', params: { track: invalid_attributes } }

      it 'returns a validation failure message' do
        expect(json['identifier']).to eq(["can't be blank"])
      end

      it_behaves_like 'http status code', 422
    end
  end

  describe 'PUT /tracks/:id' do
    let(:valid_attributes) { { identifier: 'B' } }
    let(:invalid_attributes) { { conference_id: nil } }

    context 'when the request is valid' do
      before { put "/tracks/#{track_id}", params: { track: valid_attributes } }

      it 'updates the track' do
        expect(json['identifier']).to eq('B')
      end

      it_behaves_like 'http status code', 200
    end

    context 'when the request is invalid' do
      before { put "/tracks/#{track_id}", params: { track: invalid_attributes } }

      it 'returns a validation failure message' do
        expect(json['conference']).to eq(['must exist'])
      end

      it_behaves_like 'http status code', 422
    end
  end

  describe 'DELETE /tracks/:id' do
    before { delete "/tracks/#{track_id}" }

    it_behaves_like 'http status code', 204
  end
end
