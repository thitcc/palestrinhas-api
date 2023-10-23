class AddSessionAndStartTimeToLectures < ActiveRecord::Migration[7.0]
  def change
    change_table :lectures, bulk: true do |t|
      t.string :session
      t.integer :starting_time
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE lectures
          ADD CONSTRAINT check_valid_session
          CHECK (session IN ('morning', 'afternoon'))
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE lectures
          DROP CONSTRAINT check_valid_session
        SQL
      end
    end
  end
end
