class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :book_id
      t.boolean :spoiler
      t.text    :comment
      t.decimal "score", precision: 5, scale: 3
      t.timestamps
    end
  end
end
