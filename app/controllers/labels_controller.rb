class LabelsController < ApplicationController
before_action :require_admin

  def new
    @label = Label.new
  end

  def index
    @labels = Label.all
  end

  def create
    @label = Label.new(label_params)

    if @label.save
      redirect_to labels_path, notice: "ラベル「#{@label.label_title}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @label = Label.find(params[:id])
  end

  def update
    @label = Label.find(params[:id])

    if @label.update(label_params)
      redirect_to labels_path, notice: "ラベル「#{@label.label_title}」を登録しました。"
    else
      render :new
    end
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    redirect_to labels_path, notice: "ラベル「#{@label.label_title}」を削除しました。"
  end

  private

  def label_params
    params.require(:label).permit(:label_title)
  end

  def require_admin
    render :custom_error unless current_user.admin?
  end

end
