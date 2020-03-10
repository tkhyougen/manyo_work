class Task < ApplicationRecord
  validates :name, presence: true, length:{maximum:30}
  validates :detail, presence: true
  validates :due, presence: true
end
