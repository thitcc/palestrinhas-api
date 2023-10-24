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
class TrackSerializer < ActiveModel::Serializer
  attributes :id, :identifier, :morning_session_start, :morning_session_end, :afternoon_session_start, :afternoon_session_end, :networking_event_start
  has_one :conference
  has_many :lectures

  class SimpleTrackSerializer < ActiveModel::Serializer
    attributes :identifier
  end
end
