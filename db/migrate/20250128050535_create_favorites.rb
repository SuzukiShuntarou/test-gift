class CreateFavorites < ActiveRecord::Migration[7.2]
  def change
    create_table :favorites do |t|
      t.references :goal, null: false, foreign_key: true
      t.integer :good_count, default: 0 

      t.timestamps
    end
  end
end
