class DocumentsController < ApplicationController
  def index
    @documents = Document.order(created_at: :desc)
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      # Run job synchronously for now (Solid Queue had issues with PostgreSQL)
      DocumentChunkingJob.perform_now(@document.id)
      redirect_to documents_path, notice: "Document was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_path, notice: "Document was successfully deleted."
  end

  private

  def document_params
    params.require(:document).permit(:title, :content)
  end
end
