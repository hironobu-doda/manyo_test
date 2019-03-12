class Task < ApplicationRecord
  validates :title, :content, :time_limit, presence: true
  # 未着手0,着手中1,完了2にした
  enum status:{waiting: 0, working: 1, completed: 2}
end
