class AlterInstruments < ActiveRecord::Migration[6.0]
  def change
    add_column :instruments, :owner_id, :integer
  end
end
