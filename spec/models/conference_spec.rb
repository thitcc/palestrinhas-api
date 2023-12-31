# == Schema Information
#
# Table name: conferences
#
#  id         :bigint           not null, primary key
#  end_date   :datetime         not null
#  schedule   :jsonb
#  start_date :datetime         not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Conference, type: :model do
  describe 'associations' do
    it { should have_many(:tracks).dependent(:destroy) }
  end

  describe 'validations' do
    subject { create(:conference) }

    %i[title start_date end_date].each { |attribute| it { should validate_presence_of(attribute) } }

    it 'requires end_date to be after start_date' do
      conference = build(:conference, start_date: Time.zone.today + 1.day, end_date: Time.zone.today)
      conference.valid?
      expect(conference.errors.messages[:end_date]).to include('must be after the start date')
    end
  end

  describe 'callbacks' do
    it 'creates tracks after conference creation' do
      conference = build(:conference, start_date: Time.zone.today, end_date: Time.zone.today + 1.day)
      expect { conference.save }.to change(Track, :count).by(conference.days)
    end
  end

  describe 'json_data operations' do
    let(:conference) { create(:conference, schedule: { key1: 'value1' }) }

    it 'allows adding new keys to schedule' do
      conference.schedule['key2'] = 'value2'
      conference.save
      expect(conference.reload.schedule['key2']).to eq('value2')
    end

    it 'allows reading existing keys from schedule' do
      expect(conference.schedule['key1']).to eq('value1')
    end
  end
end
