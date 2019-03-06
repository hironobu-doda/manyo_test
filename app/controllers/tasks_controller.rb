class TasksController < ApplicationController

  def new
    @task Task.new
  end

  def create
    Task.create(title: params[:task][:title], content: params[:task][:content])
  end

  def index
  end
end
