class Task < ApplicationRecord
  validates :title, :content, :time_limit, presence: true
end
