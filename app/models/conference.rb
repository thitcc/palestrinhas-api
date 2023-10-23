# == Schema Information
#
# Table name: conferences
#
#  id         :bigint           not null, primary key
#  end_date   :datetime         not null
#  start_date :datetime         not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Conference < ApplicationRecord
  has_many :tracks, dependent: :destroy

  after_create :create_tracks

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true, date: { after: :start_date, message: 'must be after the start date' }

  def create_tracks
    track_char_code = 65 # A

    days.times do
      Track.create!(identifier: track_char_code.chr, conference: self)
      track_char_code += 1 # Next character
    end
  end

  def days
    (start_date.to_date..end_date.to_date).count
  end
end
