class Label < ApplicationRecord
  has_many :midlabels, dependent: :destroy
  has_many :tasks, through: :midlabels, source: :task
end
