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
FactoryBot.define do
  factory :lecture do
    title { Faker::Fantasy::Tolkien.poem }
    duration { Faker::Number.within(range: 5..60) }
  end
end
