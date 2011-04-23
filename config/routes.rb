Q17::Application.routes.draw do
  
  match "/logout" => "sessions#destroy", :as => :logout
  match "/login"  => "sessions#new", :as => :login
  
  #TODO :need to be refactor
  match "/update_in_place" => "pages#update_in_place"
  
  match "/followed" => "pages#followed"
  match "/recommended" => "pages#recommended"
  match "/muted" => "home#muted"
  match "/doing" => "logs#index"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.


  resources :user_registrations, :controller => "registrations"
  
  resources :asks do
    member do
      get "spam"
      get "follow"
      get "unfollow"
      get "mute"
      get "unmute"
      post "answer"
      post "update_topic"
      get "update_topic"
      get "redirect"
      get "invite_to_answer"
      get "share"
      post "share"
    end
  end
  
  resources :comments 
  
  resources :answers do
    member do
      get "vote"
      get "spam"
      get "thank"
    end
  end
  
  resources :topics, :constraints => { :id => /[a-zA-Z\w\s\.%\-_]+/ } do
    member do
      get "follow"
      get "unfollow"
    end
  end
  
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
  # root :to => "welcome#index"
  root :to => "pages#home"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
