# frozen_string_literal: true

module Api
  module V1
    class TaskListsController < ApiController
      before_action :set_task_list, only: %i[show update destroy]

      def index
        @task_lists = TaskList.where(open: true)

        render json: @task_lists
      end

      def show
        render json: @task_list
      end

      def create
        @task_list = TaskList.new(task_list_params.merge(user: @current_user))

        if @task_list.save
          render json: @task_list
        else
          render json: { errors: @task_list.errors },
                 status: :unprocessable_entity
        end
      end

      def update
        if @task_list.update(task_list_params)
          render json: @task_list
        else
          render json: { errors: @task_list.errors },
                 status: :unprocessable_entity
        end
      end

      def destroy
        if @task_list.destroy
          head :ok
        else
          render json: { errors: @task_list.errors }, status: :conflict
        end
      end

      private

      def set_task_list
        @task_list = TaskList.find(params[:id])
      end

      def task_list_params
        params.require(:task_list).permit(:title, :open, :favorite)
      end
    end
  end
end
