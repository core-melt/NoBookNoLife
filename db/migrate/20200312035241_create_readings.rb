class CreateReadings < ActiveRecord::Migration[5.2]
  def change
    create_table :readings do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :reading_status
      t.boolean :readed_status
      t.timestamps
    end
  end
end
