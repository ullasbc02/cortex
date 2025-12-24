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
      # Queue job for asynchronous processing
      DocumentChunkingJob.perform_later(@document.id)
      redirect_to documents_path, notice: "Document created. Processing in background..."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_path, notice: "Document was successfully deleted."
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    if @document.update(document_params)
      redirect_to documents_path, notice: "Document was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def document_params
    params.require(:document).permit(:title, :content)
  end
end
