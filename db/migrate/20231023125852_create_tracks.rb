class CreateTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks do |t|
      t.string :identifier, null: false
      t.integer :morning_session_start
      t.integer :morning_session_end
      t.integer :afternoon_session_start
      t.integer :afternoon_session_end
      t.integer :networking_event_start
      t.references :conference, null: false, foreign_key: true

      t.timestamps
    end
  end
end
