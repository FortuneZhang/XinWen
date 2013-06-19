class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :content
      t.integer :author_id
      t.boolean :is_show_public
      t.integer :item_id

      t.timestamps
    end

  end
end
