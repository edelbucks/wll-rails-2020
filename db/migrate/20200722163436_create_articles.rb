class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.integer :version
      t.string :directory
      t.string :sha
      t.jsonb :meta
      t.text :description
      t.text :content
      t.boolean :published
      t.boolean :on_homepage
      t.date :file_created
      t.date :file_revised
      t.string :path

      t.timestamps
    end
  end
end
