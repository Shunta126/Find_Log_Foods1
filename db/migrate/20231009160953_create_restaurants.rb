class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.integer :customer_id,    null: false
      t.integer :genre_id,       null: false
      t.string :restaurant_name, null: false
      t.string :place,           null: false
      t.string :food_name,       null: false
      t.text :body,              null: false
      t.integer :price,          null: false
      t.timestamps
    end
  end
end
