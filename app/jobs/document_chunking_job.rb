class DocumentChunkingJob < ApplicationJob
  queue_as :default

  def perform(document_id)
    document = Document.find(document_id)

    return if document.document_chunks.exists?

    DocumentChunker.new(document).call

    document.document_chunks.find_each do |chunk|
      DocumentEmbeddingJob.perform_now(chunk.id)
    end
  end
end
