class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :directory
      t.string :title
      t.boolean :published
      t.string :content
      t.integer :sequence

      t.timestamps
    end
  end
end
