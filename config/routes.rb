Shirtorder::Application.routes.draw do
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
  # match ':controller(/:action(/:id(.:format)))'

  match 'o/:token' => 'realms#order'
  match 'o/:token/manifest' => 'realms#manifest'
  match 'a/:admin_token' => 'realms#admin'
  match 'a/:admin_token/pay' => 'realms#pay'
  match 'a/:admin_token/credit' => 'realms#credit'
 
  match 'payments/confirm' => 'payments#confirm' 
  match 'payments/thanks' => 'payments#thanks'

  resources :orders do
    member do
      get 'pay'
    end
    collection do
	  post 'lookup'
	end
  end

  resources :events do
    member do
      get 'auth'
      post 'auth'
      get 'orders'
      get 'auth_wepay'
      post 'auth_wepay'
    end
  end

  resources :organizations do
    collection do
      post 'add_multiple'
    end
  end
end
