class RenameDesscriptionToDescription < ActiveRecord::Migration[7.2]
  def change
    rename_column :items, :desscription, :description
  end
end
