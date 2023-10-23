class AddReferenceToTracksInLectures < ActiveRecord::Migration[7.0]
  def change
    add_reference :lectures, :track, null: false, foreign_key: true
  end
end
