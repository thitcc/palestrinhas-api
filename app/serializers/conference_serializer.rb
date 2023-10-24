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
class ConferenceSerializer < ActiveModel::Serializer
  attributes :id, :title, :start_date, :end_date, :schedule
  has_many :tracks
end
