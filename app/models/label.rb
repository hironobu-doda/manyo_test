class Label < ApplicationRecord
  has_many :tasklabels, dependent: :destroy
  has_many :tasklabel_tasks, through: :tasklabel, source: :task
end
