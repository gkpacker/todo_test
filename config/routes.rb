Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :task_lists, only: %i[index show create update destroy] do
        resources :tasks, only: %i[index create]
      end

      resources :tasks, only: %i[show update destroy] do
        member do
          put 'done', to: 'tasks#done'
          put 'pending', to: 'tasks#pending'
        end
      end
    end
  end
end
