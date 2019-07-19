# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    describe TaskListsController, type: :controller do
      include_examples 'api authentication'

      let!(:task_list) { FactoryBot.create(:task_list) }
      let!(:private_task_list) { FactoryBot.create(:task_list, open: false) }

      before do
        basic_authentication_login
      end

      describe 'GET #index' do
        it 'returns only public task lists' do
          get :index

          expect(assigns(:task_lists)).to eq([task_list])
        end
      end

      describe 'GET #show' do
        it 'assigns the requested task_list to task_list' do
          get :show, params: { id: task_list.id }

          expect(assigns(:task_list)).to eq(task_list)
        end
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          it 'creates a new task list' do
            params = { task_list: FactoryBot.attributes_for(:task_list) }

            expect { post :create, params: params }
              .to change(TaskList, :count).by(1)
          end
        end

        context 'with invalid attributes' do
          it 'does not save the new task list' do
            params = {
              task_list: FactoryBot.attributes_for(:task_list, :invalid)
            }

            expect { post :create, params: params }
              .not_to change(TaskList, :count)
          end
        end
      end

      describe 'PUT #update' do
        context 'with valid attributes' do
          it 'assigns the requested task list' do
            params = {
              id: task_list,
              task_list: FactoryBot.attributes_for(:task_list)
            }

            put :update, params: params

            expect(assigns(:task_list)).to eq(task_list)
          end

          it "changes task_list's attributes" do
            params = {
              id: task_list,
              task_list: FactoryBot.attributes_for(:task_list, title: 'Updated title')
            }

            put :update, params: params

            task_list.reload

            expect(task_list.title).to eq('Updated title')
          end
        end

        context 'with invalid attributes' do
          it 'assigns the requested task list' do
            params = {
              id: task_list,
              task_list: FactoryBot.attributes_for(:task_list, :invalid)
            }

            put :update, params: params

            expect(assigns(:task_list)).to eq(task_list)
          end

          it "doesn't changes task_list's attributes" do
            params = {
              id: task_list,
              task_list: FactoryBot.attributes_for(:task_list, title: '')
            }

            put :update, params: params

            task_list.reload

            expect(task_list.title).not_to eq('')
          end
        end
      end

      describe 'DELETE #destroy' do
        it 'deletes the task list' do
          expect {
            delete :destroy, params: { id: task_list }
          }.to change(TaskList, :count).by(-1)
        end
      end
    end
  end
end
