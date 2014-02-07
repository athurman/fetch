class CreateShelterdogs < ActiveRecord::Migration
  def change
    create_table :shelterdogs do |t|
      t.string :name
      t.string :breed
      t.string :shelter
      t.string :age
      t.string :weight
      t.string :status
    end
  end
end