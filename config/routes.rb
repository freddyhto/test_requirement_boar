Rails.application.routes.draw do

  root 'issues#board'

  resources :sessions, only: ['new', 'create', 'destroy'] do
    collection do
      get 'authorization_request'
    end
  end

  resources :issues do
    collection do
      post 'score'
      get 'board'
    end
  end
end
