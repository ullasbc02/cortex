class AddEmbeddingToDocuments < ActiveRecord::Migration[8.1]
  def change
    add_column :documents, :embedding, :vector, limit: 1536
  end
end
