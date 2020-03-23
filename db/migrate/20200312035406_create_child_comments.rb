class CreateChildComments < ActiveRecord::Migration[5.2]
  def change
    create_table :child_comments do |t|
      t.integer :comment_id
      t.integer :parent_id
      t.timestamps
    end
  end
end
