class TasklabelsController < ApplicationController
  def create
    tasklabel = task.tasklabels.create(label_id: params[:label_ids])
  end
end
