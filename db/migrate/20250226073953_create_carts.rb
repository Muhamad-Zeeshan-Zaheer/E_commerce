class CreateCarts < ActiveRecord::Migration[7.2]
  def change
    create_table :carts do |t|
      t.string :user_id
      t.string :integer

      t.timestamps
    end
  end
end
