class AnswerGenerator
  OLLAMA_URL = "http://localhost:11434/api/generate"
  MODEL = "llama3"

  ANSWER_PROMPT = <<~PROMPT
    You are an assistant answering questions using ONLY the provided context.
    Do NOT use outside knowledge.
    If the answer is not explicitly stated in the context, say: "I don't know."
    When answering, cite the relevant context sections using [1], [2], etc.

    Context:
    {{context}}

    Question:
    {{question}}

    Answer:
  PROMPT

  def self.answer(question, chunks = nil)
    chunks ||= SemanticSearchService.search(question, limit: 5)
    return "I don't know." if chunks.empty?

    context = chunks.each_with_index.map do |c, i|
      "[#{i+1}] #{c.content}"
    end.join("\n\n")

    prompt = ANSWER_PROMPT
               .gsub("{{context}}", context)
               .gsub("{{question}}", question)

    uri = URI(OLLAMA_URL)
    response = Net::HTTP.post(
      uri,
      {
        model: MODEL,
        prompt: prompt,
        stream: false
      }.to_json,
      "Content-Type" => "application/json"
    )

    return "Error: Unable to generate answer. Is Ollama running with #{MODEL}?" unless response.is_a?(Net::HTTPSuccess)

    json = JSON.parse(response.body)
    json["response"]
  rescue StandardError => e
    "Error generating answer: #{e.message}"
  end
end
