class CreateCheerings < ActiveRecord::Migration[7.2]
  def change
    create_table :cheerings do |t|
      t.references :goal, null: false, foreign_key: true
      t.integer :cheering_count, default: 0 

      t.timestamps
    end
  end
end
