# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApiController
      before_action :set_task_list, only: %i[index create]
      before_action :set_task, only: %i[show update destroy done pending]

      def index
        @tasks = @task_list.tasks

        render json: @tasks
      end

      def show
        render json: @task
      end

      def create
        @task = Task.new(task_params.merge(task_list: @task_list))

        if @task.save
          render json: @task
        else
          render json: { errors: @task.errors },
                 status: :unprocessable_entity
        end
      end

      def update
        if @task.update(task_params)
          render json: @task
        else
          render json: { errors: @task.errors },
                 status: :unprocessable_entity
        end
      end

      def destroy
        if @task.destroy
          head :ok
        else
          render json: { errors: @task.errors }, status: :conflict
        end
      end

      def done
        change_task_status(true)

        render json: @task
      end

      def pending
        change_task_status(false)

        render json: @task.reload
      end

      private

      def set_task_list
        @task_list = TaskList.find(params[:task_list_id])
      end

      def set_task
        @task = Task.find(params[:id])
      end

      def task_params
        params.require(:task).permit(:title, :description, :done, :subtask)
      end

      def change_task_status(status)
        @task.done = status

        @task.save
      end
    end
  end
end
