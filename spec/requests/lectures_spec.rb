require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/lectures", type: :request do
  let!(:lectures) { create_list(:lecture, 10) }
  let(:lecture_id) { lectures.first.id }

  describe "GET /lectures" do
    before { get '/lectures' }

    it 'returns lectures' do
      expect(json.size).to eq(10)
    end

    it_behaves_like 'http status code', 200
  end

  describe "GET /lectures/:id" do
    before { get "/lectures/#{lecture_id}" }

    context 'when the record exists' do
      it 'returns the lecture' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(lecture_id)
      end

      it_behaves_like 'http status code', 200
    end

    context 'when the record does not exist' do
      let(:lecture_id) { 100 }

      it_behaves_like 'http status code', 404
    end
  end

  describe "POST /lectures" do
    let(:valid_attributes) { { title: 'Foobar', duration: 30 } }
    let(:invalid_attributes) { { title: 'Foobar' } }

    context "when the request is valid" do
      before { post '/lectures', params: { lecture: valid_attributes } }

      it "creates a lecture" do
        expect(json['title']).to eq('Foobar')
      end

      it_behaves_like 'http status code', 201
    end

    context "when the request is invalid" do
      before { post '/lectures', params: { lecture: invalid_attributes } }

      it "returns a validation failure message" do
        expect(json['duration']).to eq(["can't be blank", "is not a number"])
      end

      it_behaves_like 'http status code', 422
    end
  end

  describe "PUT /lectures/:id" do
    let(:valid_attributes) { { title: 'Updated Title' } }
    let(:invalid_attributes) { { duration: -1 } }

    context "when the record exists" do
      context "when the request is valid" do
        before { put "/lectures/#{lecture_id}", params: { lecture: valid_attributes } }

        it "updates the lecture" do
          expect(json['title']).to eq('Updated Title')
        end

        it_behaves_like 'http status code', 200
      end

      context "when the request is invalid" do
        before { put "/lectures/#{lecture_id}", params: { lecture: invalid_attributes } }

        it "returns a validation failure message" do
          expect(json['duration']).to eq(["must be greater than 0"])
        end

        it_behaves_like 'http status code', 422
      end
    end
  end

  describe "DELETE /lectures/:id" do
    before { delete "/lectures/#{lecture_id}" }

    it_behaves_like 'http status code', 204
  end
end
