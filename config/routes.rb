Rails.application.routes.draw do
  namespace 'api' do
    resources :articles, only: [:show, :index]
    resources :categories, only: [:show, :index]

    get 'homepage-articles', to: 'articles#homepage'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
