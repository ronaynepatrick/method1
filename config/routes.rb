Method1::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  # The priority is based upon order of creation:
  # first created -> highest priority.
 #config/routes.rb
  resources :user_sessions

  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout

  resources :users  # give us our some normal resource routes for users
  resource :user, :as => 'account'  # a convenience route

  match 'signup' => 'users#new', :as => :signup

  root :to => 'users#new'

  match 'home_page' => "home_page#load", :as => :home_page
  match 'search' => "header#search", :as => :search

  #page_creator stuff
  match 'create_page' => "page_creator#new", :as => :create_page
  match 'save_page' => "page_creator#save_new", :as => :save_new
  match 'edit_page' => "page_creator#edit_page", :as => :edit_page
  match 'new_passage' => "page_creator#new_passage", :as => :new_passage
  match 'edit_passage' => "page_creator#edit_passage", :as => :edit_passage
  match 'save_passage' => "page_creator#save_passage", :as => :save_passage
  match 'move_up' => "page_creator#move_up", :as => :move_up
  match 'move_down' => "page_creator#move_down", :as => :move_down
  match 'delete_passage' => "page_creator#delete_passage", :as => :delete_passage

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
