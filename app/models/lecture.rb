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
class Lecture < ApplicationRecord
  validates :title, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
