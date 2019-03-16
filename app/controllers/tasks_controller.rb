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
      # @tasks = Task.where(title: params[:title])
      # @tasks = Task.where(status: params[:status][:name])
      if params[:title].present? && params[:status].present?
        @tasks = Task.page(params[:page]).serch_all(params[:title], params[:status])
      elsif params[:status].present?
        @tasks = Task.page(params[:page]).serch_status(params[:status])
      else
        @tasks = Task.page(params[:page]).serch_title(params[:title])
      end
    else
      if params[:sort_expired]
        # @tasks = Task.all.order(time_limit: :desc)
        @tasks = Task.page(params[:page]).time_limit
      elsif params[:sort_priority]
        # @tasks = Task.all.order(priority: :desc)
        @tasks = Task.page(params[:page]).priority
      else
        # @tasks = Task.all.order(created_at: :desc)
        # @tasks = Task.created_at
        @tasks = Task.page(params[:page]).created_at
      end
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

end
