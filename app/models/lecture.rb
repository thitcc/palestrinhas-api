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
class Lecture < ApplicationRecord
  belongs_to :track

  SESSIONS = %w[morning afternoon].freeze

  validates :title, presence: true
  validates :duration, :starting_time, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :session, presence: true, inclusion: { in: SESSIONS }
end
