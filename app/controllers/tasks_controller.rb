class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  PER = 5

  def index
    # @q = Task.ransack(params[:q])
    # @tasks = @q.result(distinct: true)
    #

    @tasks = Task.all.order(created_at:"DESC")

    #終了期限で昇降ソート
    if params[:sort_expired_dsc]
      @tasks = Task.all.order(due:"DESC")
    elsif params[:sort_expired_asc]
      @tasks = Task.all.order(due:"ASC")
    else
      @tasks = Task.all.order(created_at:"DESC")
    end

    #優先度でソート
    if params[:sort_priority_high]
      @tasks = Task.all.order(priority:"ASC")
    end

    #検索　タスクとステータス
    if params[:task]&& params[:task][:search].present?
      @tasks = Task.where("name Like ?", "%#{params[:task][:name]}%")
      @tasks = @tasks.where("status Like ?","%#{params[:task][:status]}%")
    end

    @tasks = @tasks.page(params[:page]).per(PER)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
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
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :detail, :due,:priority, :status, :label)
    end

    def check_user
    unless logged_in?
        flash[:notice] = "ログインしてください"
        redirect_to new_session_path, notice:"ログインしてください"
    end
end
