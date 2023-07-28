class CreateAmenities < ActiveRecord::Migration[6.0]
  def change
    create_table :amenities do |t|
      t.string :category
      t.string :name, null: false
      t.string :hotel_id, null: false

      t.timestamps
    end
    add_index :amenities, [:hotel_id, :name], unique: true
  end
end
