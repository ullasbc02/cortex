class DocumentChunkingJob < ApplicationJob
  queue_as :default

  def perform(document_id)
    document = Document.find(document_id)

    return if document.document_chunks.exists?

    DocumentChunker.new(document).call

    # Queue all embedding jobs asynchronously for parallel processing
    document.document_chunks.find_each do |chunk|
      DocumentEmbeddingJob.perform_later(chunk.id)
    end
  end
end
