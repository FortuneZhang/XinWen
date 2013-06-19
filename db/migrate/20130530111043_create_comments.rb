class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

      t.string :content
      t.boolean :is_show_public
      t.references :user
      t.references :news

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :news_id
  end
end
