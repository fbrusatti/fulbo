class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.references :fixture
      t.integer :number
      t.date  :date
      t.timestamps
    end
  end
end
