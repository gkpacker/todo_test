# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    describe TasksController, type: :controller do
      include_examples 'api authentication'

      let!(:task_list) { FactoryBot.create(:task_list) }
      let!(:task) { FactoryBot.create(:task, task_list: task_list) }

      before do
        basic_authentication_login
      end

      describe 'GET #index' do
        it "returns given task list's tasks" do
          get :index, params: { task_list_id: task_list.id }

          expect(assigns(:tasks)).to eq([task])
        end
      end

      describe 'GET #show' do
        it 'assigns the requested task' do
          get :show, params: { id: task.id }

          expect(assigns(:task)).to eq(task)
        end
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          it 'creates a new task' do
            params = {
              task_list_id: task_list.id,
              task: FactoryBot.attributes_for(:task)
            }

            expect { post :create, params: params }
              .to change(Task, :count).by(1)
          end
        end

        context 'with invalid attributes' do
          it 'does not save the new task list' do
            params = {
              task_list_id: task_list.id,
              task: FactoryBot.attributes_for(:task, :invalid)
            }

            expect { post :create, params: params }
              .not_to change(Task, :count)
          end
        end
      end

      describe 'PUT #update' do
        context 'with valid attributes' do
          it 'assigns the requested task' do
            params = {
              id: task,
              task: FactoryBot.attributes_for(:task)
            }

            put :update, params: params

            expect(assigns(:task)).to eq(task)
          end

          it "changes task's attributes" do
            params = {
              id: task,
              task: FactoryBot.attributes_for(:task, title: 'Updated title')
            }

            put :update, params: params

            task.reload

            expect(task.title).to eq('Updated title')
          end
        end

        context 'with invalid attributes' do
          it 'assigns the requested task list' do
            params = {
              id: task,
              task: FactoryBot.attributes_for(:task, :invalid)
            }

            put :update, params: params

            expect(assigns(:task)).to eq(task)
          end

          it "doesn't changes task's attributes" do
            params = {
              id: task,
              task: FactoryBot.attributes_for(:task, title: '')
            }

            put :update, params: params

            task.reload

            expect(task.title).not_to eq('')
          end
        end
      end

      describe 'DELETE #destroy' do
        it 'deletes the task list' do
          expect {
            delete :destroy, params: { id: task }
          }.to change(Task, :count).by(-1)
        end
      end

      describe 'PUT #done' do
        it "sets 'done' attribute to true" do
          task.update_attributes(done: false)

          expect {
            put :done, params: { id: task.id }
          }.to change { task.reload.done }.from(false).to(true)
        end
      end

      describe 'PUT #pending' do
        it "sets 'done' attribute to false" do
          task.update_attributes(done: true)

          expect {
            put :pending, params: { id: task.id }
          }.to change { task.reload.done }.from(true).to(false)
        end
      end
    end
  end
end
