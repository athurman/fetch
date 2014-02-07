class CreateShelters < ActiveRecord::Migration
  def change
    create_table :shelters do |t|
      t.string :name
      t.integer :location
      t.string :petfinder_id
    end
  end
end