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
class Lecture < ApplicationRecord
  belongs_to :track

  validates :title, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
