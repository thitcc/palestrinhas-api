require 'rails_helper'
require_relative '../../fixtures/lectures_data'

RSpec.describe Organizer::LectureOrganizerBacktrackService, type: :service do
  let(:conference) { create(:conference) }

  let!(:lectures_input) { LECTURE_DATA.dup }
  let!(:expected_schedule_output) { File.read(Rails.root.join('spec/fixtures/expected_schedule_output.txt')) }

  describe '.organize' do
    context 'when there are no lectures to organize' do
      it 'returns a message indicating there are no lectures to organize' do
        result = described_class.organize(conference, [])

        expect(result).to eq('No lectures to organize')
      end
    end

    context 'when there are lectures to organize' do
      it 'returns the organized schedule for the lectures' do
        result = described_class.organize(conference, lectures_input)

        expect(JSON.parse(result.to_json)).to eq(JSON.parse(expected_schedule_output.to_s))
      end
    end

    context 'when not all lectures can be allocated within the day' do
      let(:track) { create(:track, conference: conference) }
      let(:lectures) { create_list(:lecture, 99, track: track) }

      it 'returns a message indicating not all lectures could be allocated' do
        result = described_class.organize(conference, lectures)

        expect(result).to eq('Not all lectures could be allocated within the tracks')
      end
    end
  end
end
