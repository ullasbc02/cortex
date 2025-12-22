class CreateDocumentChunks < ActiveRecord::Migration[8.1]
  def change
    create_table :document_chunks do |t|
      t.references :document, null: false, foreign_key: true
      t.text :content, null: false
      t.integer :position, null: false

      t.timestamps
    end
  end
end
