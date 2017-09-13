Rails.application.routes.draw do

  get 'users/create'

  post 'user_token' => 'user_token#create'

  devise_for :users

  namespace 'api' do
    namespace 'v1' do
      resources :mangas do
        resources :manga_contents, only: [:show, :index]
      end
      resources :users, only: [:create]
    end
  end

end
