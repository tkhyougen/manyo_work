class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:index]

  PER = 5

  def index
    @tasks = current_user.tasks.order(created_at:"DESC")

    #終了期限で昇降ソート
    if params[:sort_expired_dsc]
      @tasks = current_user.tasks.all.order(due:"DESC")
    elsif params[:sort_expired_asc]
      @tasks = current_user.tasks.all.order(due:"ASC")
    else
      @tasks = current_user.tasks.all.order(created_at:"DESC")
    end

    #優先度でソート
    if params[:sort_priority_high]
      @tasks = current_user.tasks.all.order(priority:"ASC")
    end

  #検索をかける場合分け
  if params[:search].present?
    if params[:search][:name].present? && params[:search][:status].present? && params[:search][:label_id].present?
      @tasks = current_user.tasks.where("name Like ?", "%#{params[:search][:name]}%")
      @tasks = @tasks.where(status: params[:search][:status])
      @mid_label = Midlabel.where(label_id: params[:search][:label_id]).pluck(:task_id)
      @tasks = @tasks.where(id: @mid_label)

    elsif params[:search][:name].present? && params[:search][:status].present?
      @tasks = current_user.tasks.where("name Like ?", "%#{params[:search][:name]}%")
      @tasks = @tasks.where(status: params[:search][:status])

    elsif params[:search][:name].present? && params[:search][:label_id].present?
      @tasks = current_user.tasks.where("name Like ?", "%#{params[:search][:name]}%")
      @mid_label = Midlabel.where(label_id: params[:search][:label_id]).pluck(:task_id)
      @tasks = @tasks.where(id: @mid_label)

    elsif params[:search][:status].present? && params[:search][:label_id].present?
      @tasks = @tasks.where(status: params[:search][:status])
      @mid_label = Midlabel.where(label_id: params[:search][:label_id]).pluck(:task_id)
      @tasks = @tasks.where(id: @mid_label)

    elsif params[:search][:name].present?
      @tasks = current_user.tasks.where("name Like ?", "%#{params[:search][:name]}%")

    elsif params[:search][:status].present?
      @tasks = @tasks.where(status: params[:search][:status])

    elsif params[:search][:label_id].present?
      @mid_label = Midlabel.where(label_id: params[:search][:label_id]).pluck(:task_id)
      @tasks = @tasks.where(id: @mid_label)
    end
  end

    #表示数をPERで5つに
      @tasks = @tasks.page(params[:page]).per(PER)
  end

  def show
  end

  def new
    @task = Task.new
    @labels = Label.all
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)
    # @task.user_id = current_user.id  #不要

    if @task.save
      redirect_to @task, notice: 'Taskが作られました'
    else
      render :new
    end

  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "#{@task.name}を編集しました！"
    else
      render :edit
    end
  end


  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"#{@task.name}を削除しました！"
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :detail, :due, :priority, :status, {label_ids: []} )
    end

    def check_user
      unless logged_in?
        flash[:notice] = "ログインしてください"
        redirect_to new_session_path, notice:"ログインしてください"
      end
    end

end
