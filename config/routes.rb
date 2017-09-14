Rails.application.routes.draw do

  post 'user_token' => 'user_token#create'

  devise_for :users

  namespace 'api' do
    namespace 'v1' do
      resources :manga_titles do
        resources :mangas
      end
      resources :users, only: [:create]
    end
  end

end
