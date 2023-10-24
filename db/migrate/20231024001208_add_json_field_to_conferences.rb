class AddJsonFieldToConferences < ActiveRecord::Migration[7.0]
  def change
    add_column :conferences, :schedule, :jsonb
  end
end
