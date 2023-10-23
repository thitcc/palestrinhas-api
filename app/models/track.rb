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
class Track < ApplicationRecord
  belongs_to :conference

  has_many :lectures, dependent: :destroy

  before_create :set_default_times

  validates :identifier, presence: true

  private

  def set_default_times
    self.morning_session_start   ||= 9 * 60   # 9:00 AM
    self.morning_session_end     ||= 12 * 60  # 12:00 PM
    self.afternoon_session_start ||= 13 * 60  # 13:00 PM
    self.afternoon_session_end   ||= 17 * 60  # 17:00 PM
    self.networking_event_start  ||= 16 * 60  # 16:00 PM
  end
end
