class CreateHotels < ActiveRecord::Migration[6.0]
  def change
    create_table :hotels, :id => false do |t|
      t.string :id, primary_key: true
      t.integer :destination_id, null: false
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :hotels, [:id, :destination_id], unique: true
  end
end
