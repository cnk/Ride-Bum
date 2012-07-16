class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.integer :event_id
      t.integer :driver_id
      t.integer :free_seats

      t.timestamps
    end
  end
end
