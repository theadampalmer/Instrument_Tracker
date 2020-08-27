class CreateInstruments < ActiveRecord::Migration[6.0]
    def change
      create_table :instruments do |t|
      t.text :description
      t.string :manufacturer
      t.integer :model_year
    end
  end
end
