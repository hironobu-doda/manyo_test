class AddTimeLimitToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :time_limit, :date, null:false, default: Date.today
  end
end
