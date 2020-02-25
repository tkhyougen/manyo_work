class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
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
      redirect_to tasks_path, notice: 'Taskが作られました'
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
      params.require(:task).permit(:name, :detail, :due ,:priority, :status, :label)
    end

end
