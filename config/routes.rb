Rails.application.routes.draw do
  namespace 'api' do
    resources :articles, only: [:index]
    resources :categories, only: [:index]

    get 'homepage-articles', to: 'articles#homepage'
    get 'articles/*path', to: 'articles#by_path'
    get 'articles/*path.md', to: 'articles#by_path'

    get 'categories/*path', to: 'categories#by_path'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
