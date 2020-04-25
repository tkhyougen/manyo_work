class Task < ApplicationRecord
  validates :name, presence: true, length:{maximum:30}
  validates :detail, presence: true
  validates :due, presence: true
  enum priority: {"高":0, "中":1, "低":2}

  belongs_to :user
end
