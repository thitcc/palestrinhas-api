# == Schema Information
#
# Table name: tracks
#
#  id                      :bigint           not null, primary key
#  afternoon_session_end   :integer
#  afternoon_session_start :integer
#  identifier              :string           not null
#  morning_session_end     :integer
#  morning_session_start   :integer
#  networking_event_start  :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  conference_id           :bigint           not null
#
# Indexes
#
#  index_tracks_on_conference_id  (conference_id)
#
# Foreign Keys
#
#  fk_rails_...  (conference_id => conferences.id)
#
require 'rails_helper'

RSpec.describe Track, type: :model do
  describe 'associations' do
    it { should belong_to(:conference) }
  end

  describe 'validations' do
    %i[identifier].each { |attribute| it { should validate_presence_of(attribute) } }
  end

  describe 'callbacks' do
    context 'when times are not provided' do
      let(:conference) { create(:conference) }
      let(:track) { create(:track, conference: conference) }

      before do
        track.valid?
      end

      it 'sets default morning_session_start before validation' do
        expect(track.morning_session_start).to eq(9 * 60)
      end

      it 'sets default morning_session_end before validation' do
        expect(track.morning_session_end).to eq(12 * 60)
      end

      it 'sets default afternoon_session_start before validation' do
        expect(track.afternoon_session_start).to eq(13 * 60)
      end

      it 'sets default afternoon_session_end before validation' do
        expect(track.afternoon_session_end).to eq(17 * 60)
      end

      it 'sets default networking_event_start before validation' do
        expect(track.networking_event_start).to eq(16 * 60)
      end
    end
  end
end
