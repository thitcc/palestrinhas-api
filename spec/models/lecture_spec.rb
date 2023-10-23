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
require 'rails_helper'

RSpec.describe Lecture, type: :model do
  describe 'associations' do
    it { should belong_to(:track) }
  end

  describe 'validations' do
    %i[title duration].each { |attribute| it { should validate_presence_of(attribute) } }

    it { should validate_numericality_of(:duration).only_integer.is_greater_than(0) }
  end
end
