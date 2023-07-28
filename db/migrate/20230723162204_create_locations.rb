class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations, id: false do |t|
      t.decimal :lat, precision: 15, scale: 10
      t.decimal :lng, precision: 15, scale: 10
      t.string :address
      t.string :city
      t.string :country
      t.string :postal_code
      t.string :hotel_id, null: false

      t.timestamps
    end
    add_index :locations, [:hotel_id], unique: true
  end
end
