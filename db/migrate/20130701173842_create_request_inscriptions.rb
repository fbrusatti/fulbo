class CreateRequestInscriptions < ActiveRecord::Migration
  def change
    create_table :request_inscriptions do |t|
      t.references :requester, polymorphic: true
      t.references :requested, polymorphic: true
      t.string :status, default: "waiting"

      t.timestamps
    end

    add_index :request_inscriptions, [:requester_id, :requester_type]
    add_index :request_inscriptions, [:requested_id, :requested_type]
  end
end
