Rails.application.routes.draw do
  devise_for :users

	root 'home#top'
	# get '/' => 'homes#top'
	get 'home/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :edit, :update, :create, :destroy]
  resources :books, only: [:index, :show, :edit, :update, :create, :destroy]
end
