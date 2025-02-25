class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :desscription
      t.decimal :price

      t.timestamps
    end
  end
end
