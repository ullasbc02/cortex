class SearchController < ApplicationController
  def index
    query = params[:q].to_s.strip

    respond_to do |format|
      format.html do
        @query = query

        if query.present?
          @chunks = SemanticSearchService.search(query, limit: 5)
          @answer = AnswerGenerator.answer(query, @chunks)
        else
          @chunks = []
          @answer = nil
        end
      end

      format.json do
        return render json: { error: "q is required" }, status: 400 if query.blank?

        chunks = SemanticSearchService.search(query, limit: 5)

        render json: chunks.map { |c|
          {
            document_id: c.document_id,
            chunk_id: c.id,
            position: c.position,
            distance: c.distance,
            content: c.content
          }
        }
      end
    end
  end
end
