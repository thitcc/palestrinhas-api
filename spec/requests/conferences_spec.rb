require 'rails_helper'

RSpec.describe '/conferences', type: :request do
  let!(:conferences) { create_list(:conference, 10) }
  let(:conference_id) { conferences.first.id }

  describe 'GET /conferences' do
    before { get '/conferences' }

    it 'returns conferences' do
      expect(json.size).to eq(10)
    end

    it_behaves_like 'http status code', 200
  end

  describe 'GET /conferences/:id' do
    before { get "/conferences/#{conference_id}" }

    context 'when the record exists' do
      it 'returns the conference' do
        expect(json['id']).to eq(conference_id)
      end

      it_behaves_like 'http status code', 200
    end

    context 'when the record does not exist' do
      let(:conference_id) { 100 }

      it_behaves_like 'http status code', 404
    end
  end

  describe 'POST /conferences' do
    let(:valid_attributes) { { title: 'Foobar', start_date: Time.zone.today, end_date: Time.zone.tomorrow } }
    let(:invalid_attributes) { { title: 'Foobar' } }

    context 'when the request is valid' do
      before { post '/conferences', params: { conference: valid_attributes } }

      it 'creates a conference' do
        expect(json['title']).to eq('Foobar')
      end

      it_behaves_like 'http status code', 201
    end

    context 'when the request is invalid' do
      before { post '/conferences', params: { conference: invalid_attributes } }

      it 'returns a validation failure message' do
        expect(json['start_date']).to eq(["can't be blank"])
      end

      it_behaves_like 'http status code', 422
    end
  end

  describe 'PUT /conferences/:id' do
    let(:valid_attributes) { { title: 'Updated Title' } }
    let(:invalid_attributes) { { start_date: Time.zone.tomorrow, end_date: Time.zone.today } }

    context 'when the request is valid' do
      before { put "/conferences/#{conference_id}", params: { conference: valid_attributes } }

      it 'updates the conference' do
        expect(json['title']).to eq('Updated Title')
      end

      it_behaves_like 'http status code', 200
    end

    context 'when the request is invalid' do
      before { put "/conferences/#{conference_id}", params: { conference: invalid_attributes } }

      it 'returns a validation failure message' do
        expect(json['end_date']).to eq(['must be after the start date'])
      end

      it_behaves_like 'http status code', 422
    end
  end

  describe 'DELETE /conferences/:id' do
    before { delete "/conferences/#{conference_id}" }

    it_behaves_like 'http status code', 204
  end
end
