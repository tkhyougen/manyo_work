class Midlabel < ApplicationRecord
  belongs_to :task
  belongs_to :label
end