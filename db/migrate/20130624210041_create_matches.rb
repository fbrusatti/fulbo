class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :visitor_id
      t.integer :local_id
      t.references :week
      t.timestamps
    end

    add_index :matches, :visitor_id
    add_index :matches, :local_id
    add_index :matches, :week_id
  end
end
