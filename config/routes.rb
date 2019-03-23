Rails.application.routes.draw do

  root 'sessions#create'

  resources :issues do
    collection do
      post 'score'
    end
  end
end
