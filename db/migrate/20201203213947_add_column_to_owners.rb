class AddColumnToOwners < ActiveRecord::Migration[5.2]
  def up
    add_column :owners, :pet_id, :integer
  end

  def down
    remove_column :owners, :pet_id
  end
end
