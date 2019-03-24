class Task < ApplicationRecord

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :time_limit, presence: true
  # 未着手0,着手中1,完了2にした
  enum status:{waiting: 0, working: 1, completed: 2}
  enum priority:{low: 0, middle: 1, high: 2}

  # scope :serch_all, -> (title, status) { where("title = ? and status = ?", title, status) }
  # scope :serch_title, -> (title) { where(title: title) }
  # scope :serch_status, -> (status) { where(status: status) }
  #
  # scope :serch_label, -> (label) {
  #   where(id:
  #     Tasklabel.where(label_id: label).map{|tasklabel| tasklabel.task_id }
  #   )
  # }



  # scope :serch_all, -> (title, status, label) { where("title = ? and status = ? and label = ?",
  #                                                     title, status, Tasklabel.where(label_id: label).map{|tasklabel| tasklabel.task_id }
  #                                                     )
  #                                             }
  #
  # scope :serch_title_status, -> (title, status) { where("title = ? and status = ?", title, status) }
  scope :serch_title, -> (title) { where(title: title) }
  scope :serch_status, -> (status) { where(status: status) }

  scope :serch_label, -> (label) {
    where(id:
      Tasklabel.where(label_id: label).map{|tasklabel| tasklabel.task_id }
    )
  }

  scope :time_limit, -> { all.order(time_limit: :desc) }
  scope :priority, -> { all.order(priority: :desc) }
  scope :created_at, -> { all.order(created_at: :desc) }

  paginates_per 10

  belongs_to :user

  has_many :tasklabels, dependent: :destroy
  has_many :tasklabel_labels, through: :tasklabels, source: :label
end
