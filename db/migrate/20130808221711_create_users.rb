class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :null => false
      t.string :password_digest, :null => false
      t.timestamps
    end

    add_column :cats, :owner_id, :integer
    add_column :cat_rental_requests, :user_id, :integer

  end
end
