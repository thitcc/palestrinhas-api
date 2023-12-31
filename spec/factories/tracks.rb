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
FactoryBot.define do
  factory :track do
    identifier { Faker::Fantasy::Tolkien.poem }
    conference { nil }
  end
end
