class CreateNotifies < ActiveRecord::Migration
  def change
    create_table :notifies do |t|
      t.string :target_id
      t.string :content
      t.string :is_read
      t.references :news
      t.references :user

      t.timestamps
    end
    add_index :notifies, :news_id
    add_index :notifies, :user_id
  end
end
