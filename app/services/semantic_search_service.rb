class SemanticSearchService
  MAX_DISTANCE = 0.8  # tune this as needed

  def self.search(query, limit: 5)
    embedding = EmbeddingGenerator.generate(query)

    DocumentChunk
      .semantic_search_with_score(embedding, limit: limit)
      .select { |c| c.distance.present? && c.distance <= MAX_DISTANCE }
  end
end
