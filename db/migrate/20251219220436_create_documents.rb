class CreateDocuments < ActiveRecord::Migration[8.1]
  def change
    unless table_exists?(:documents)
      create_table :documents do |t|
        t.string :title
        t.text :content
        t.column :embedding, :vector, limit: 1536

        t.timestamps
      end
    end
  end
end
