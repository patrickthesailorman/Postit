class CreateUsers < ActiveRecord::Migration[5.0]
  def up
    create_table :users do |t|
      t.string "username"
      t.string "email", :limit =>50, :null => false
      t.column "password", :string, :limit =>30, :null => false
      t.timestamps null: false
    end
  end

  def down
    drop_table :users
  end
end
