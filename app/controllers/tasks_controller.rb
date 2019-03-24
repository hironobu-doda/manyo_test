class TasksController < ApplicationController
   before_action :set_task, only: [:show, :edit, :update, :destroy]

  def new
    @task = Task.new
    @labels = Label.all
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save

      if tasklabel_params[:label_ids]
        tasklabel_params[:label_ids].each do |t|
          @tasklabel = @task.tasklabels.new(label_id: t)
          @tasklabel.save
        end
      end
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to tasks_path, notice: "タスク作成しました！"
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end

  def index
    if params[:search]
      task_searchs
    else
      task_sorts
    end
  end

  def show
    @tasklabel = @task.tasklabel_labels
  end

  def edit
    @labels = Label.all
  end

  def update
    if @task.update(task_params)

        if tasklabel_params[:label_ids]
          @task.tasklabels.destroy_all
          tasklabel_params[:label_ids].each do |t|
            @tasklabel = @task.tasklabels.new(label_id: t)
            @tasklabel.save
          end
        end
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :time_limit, :status, :priority)
  end

  def tasklabel_params
    params.require(:task).permit({ label_ids: [] })
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_searchs
    @tasks = current_user.tasks

    if params[:title].present?
      @tasks = @tasks.serch_title(params[:title])
    end

    if params[:status].present?
      @tasks = @tasks.serch_status(params[:status])
    end

    if params[:label].present?
      @tasks = @tasks.serch_label(params[:label])
    end

    @tasks = @tasks.page(params[:page])

  end

  def task_sorts
    if params[:sort_expired]
      # @tasks = Task.all.order(time_limit: :desc)
      @tasks = current_user.tasks.page(params[:page]).time_limit
    elsif params[:sort_priority]
      # @tasks = Task.all.order(priority: :desc)
      @tasks = current_user.tasks.page(params[:page]).priority
    else
      # @tasks = Task.all.order(created_at: :desc)
      # @tasks = Task.created_at
      @tasks = current_user.tasks.page(params[:page]).created_at
    end
  end

end
