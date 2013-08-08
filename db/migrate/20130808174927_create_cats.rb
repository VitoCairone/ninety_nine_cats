class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.integer :age
      t.date :birth_date
      t.string :color
      t.string :name, :presence => true
      t.string :sex

      t.timestamps
    end
  end
end
