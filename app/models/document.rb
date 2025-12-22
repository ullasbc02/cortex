class Document < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  has_many :document_chunks, dependent: :destroy
end
