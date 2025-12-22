require "net/http"
require "json"

class EmbeddingGenerator
  OLLAMA_URL = "http://localhost:11434/api/embeddings"
  MODEL = "nomic-embed-text"

  def self.generate(text)
    uri = URI(OLLAMA_URL)

    response = Net::HTTP.post(
      uri,
      {
        model: MODEL,
        prompt: text
      }.to_json,
      "Content-Type" => "application/json"
    )

    json = JSON.parse(response.body)

    json["embedding"]
  end
end
