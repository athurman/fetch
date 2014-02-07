class CreateBreeds < ActiveRecord::Migration
  def change
    create_table :breeds do |t|
      t.string :name
      t.string :size
      t.string :lifespan
      t.string :weight
      t.string :height
      t.integer :group_id
      t.string :exercise
      t.string :grooming
      t.string :family_friendly
      t.integer :role_id
      t.string :temperament
    end
  end
end