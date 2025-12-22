class DocumentChunker
  def initialize(document)
    @document = document
  end

  def call
    chunks = split_into_chunks(@document.content)

    chunks.each_with_index do |chunk, index|
      @document.document_chunks.create!(
        content: chunk,
        position: index
      )
    end
  end

  private

  def split_into_chunks(text)
    text
      .split(/\n{2,}/)     # split on blank lines (paragraphs)
      .map(&:strip)
      .reject(&:empty?)
  end
end
