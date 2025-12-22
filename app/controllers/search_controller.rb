class SearchController < ApplicationController
  def index
    query = params[:q].to_s.strip

    respond_to do |format|
      format.html do
        @query = query
        @chunks = query.present? ? SemanticSearchService.search(query, limit: 5) : []
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
