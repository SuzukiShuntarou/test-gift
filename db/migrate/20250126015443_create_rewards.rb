class CreateRewards < ActiveRecord::Migration[7.2]
  def change
    create_table :rewards do |t|
      t.date :completiondate
      t.text :content
      t.text :location

      t.timestamps
    end
  end
end
