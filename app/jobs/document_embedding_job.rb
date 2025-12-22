class DocumentEmbeddingJob < ApplicationJob
  queue_as :default

  def perform(document_chunk_id)
    chunk = DocumentChunk.find(document_chunk_id)

    return if chunk.embedding.present?

    embedding = EmbeddingGenerator.generate(chunk.content)

    # Convert array to pgvector format (as string representation)
    chunk.update!(embedding: embedding.to_s)
  end
end
