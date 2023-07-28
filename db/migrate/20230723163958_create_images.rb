class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :category
      t.string :url, null: false
      t.string :description
      t.string :hotel_id, null: false

      t.timestamps
    end
    add_index :images, [:hotel_id, :url], unique: true
  end
end
