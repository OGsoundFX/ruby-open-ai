class Question < ApplicationRecord
  belongs_to :conversation
  has_many :answers, dependent: :destroy
end
