# == Schema Information
#
# Table name: lectures
#
#  id         :bigint           not null, primary key
#  duration   :integer          not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  track_id   :bigint           not null
#
# Indexes
#
#  index_lectures_on_track_id  (track_id)
#
# Foreign Keys
#
#  fk_rails_...  (track_id => tracks.id)
#
FactoryBot.define do
  factory :lecture do
    title { Faker::Fantasy::Tolkien.poem }
    duration { Faker::Number.within(range: 5..60) }
    track { nil }
  end
end
