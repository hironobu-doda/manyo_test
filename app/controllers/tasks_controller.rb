class TasksController < ApplicationController
   before_action :set_task, only: [:show, :edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
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
  end

  def edit
  end

  def update
    if @task.update(task_params)
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

  def set_task
    @task = Task.find(params[:id])
  end

  def task_searchs
    if params[:title].present? && params[:status].present?
      @tasks = Task.serch_all(params[:title], params[:status])
    elsif params[:status].present?
      @tasks = Task.serch_status(params[:status])
    else params[:title].present?
      @tasks = Task.serch_title(params[:title])
    end
  end

  def task_sorts
    if params[:sort_expired]
      @tasks = Task.time_limit
    elsif params[:sort_priority]
      @tasks = Task.priority
    else
      @tasks = Task.created_at
    end
  end

end
