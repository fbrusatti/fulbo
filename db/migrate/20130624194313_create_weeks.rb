class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.references :fixture
      t.integer :number
      t.date  :start_date
      t.date  :end_date
      t.timestamps
    end

    add_index :weeks, :fixture_id
  end
end
