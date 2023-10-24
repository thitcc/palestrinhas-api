class RemoveNullConstraintFromTrackIdInLectures < ActiveRecord::Migration[7.0]
  def change
    change_column_null :lectures, :track_id, true
  end
end
