class Task < ApplicationRecord
  validates :name, presence: true, length:{maximum:30}
  validates :detail, presence: true
  validates :due, presence: true
  enum priority: {"高":0, "中":1, "低":2}

  belongs_to :user
  has_many :midlabels, dependent: :destroy
  has_many :labels, through: :midlabels, source: :label
  accepts_nested_attributes_for :labels, allow_destroy: true  ##ラベル追加

end
