class CreateLectures < ActiveRecord::Migration[7.0]
  def change
    create_table :lectures do |t|
      t.string :title, null: false
      t.integer :duration, null: false

      t.timestamps
    end
  end
end
