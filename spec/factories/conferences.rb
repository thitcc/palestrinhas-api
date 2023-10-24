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
FactoryBot.define do
  factory :conference do
    title { Faker::Fantasy::Tolkien.poem }
    start_date { Time.zone.today }
    end_date { Time.zone.tomorrow }
  end
end
