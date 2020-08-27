class CreateOwners < ActiveRecord::Migration[6.0]
   def change
    create_table :owners do |t|
      t.string :username
      t.text :email
      t.string :password_digest
    end
  end
end
