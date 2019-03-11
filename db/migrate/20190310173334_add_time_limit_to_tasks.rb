class AddTimeLimitToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :time_limit, :datetime, null:false, default: DateTime.now
  end
end
