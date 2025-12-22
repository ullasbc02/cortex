class DocumentChunk < ApplicationRecord
  belongs_to :document

  def self.semantic_search_with_score(query_embedding, limit: 5)
    select(
      "document_chunks.*, (embedding <=> '#{query_embedding.to_json}') AS distance"
    ).order("distance ASC")
     .limit(limit)
  end
end
