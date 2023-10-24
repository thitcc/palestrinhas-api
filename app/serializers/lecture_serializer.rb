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
#  track_id      :bigint
#
# Indexes
#
#  index_lectures_on_track_id  (track_id)
#
# Foreign Keys
#
#  fk_rails_...  (track_id => tracks.id)
#
class LectureSerializer < ActiveModel::Serializer
  attributes :id, :title, :duration, :session, :starting_time
  has_one :track

  class SimpleLectureSerializer < ActiveModel::Serializer
    attributes :title, :duration, :session, :starting_time, :track

    def track
      TrackSerializer::SimpleTrackSerializer.new(object.track)
    end
  end
end
