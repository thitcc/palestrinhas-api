# == Schema Information
#
# Table name: lectures
#
#  id            :bigint           not null, primary key
#  duration      :integer          not null
#  session       :string
#  starting_time :integer
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  track_id      :bigint           not null
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
    session { 'morning' }
    starting_time { Faker::Number.within(range: 1..100) }
    track { nil }
  end
end
