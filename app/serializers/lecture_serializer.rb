# == Schema Information
#
# Table name: lectures
#
#  id         :bigint           not null, primary key
#  duration   :integer          not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class LectureSerializer < ActiveModel::Serializer
  attributes :id, :title, :duration
end
