Rails.application.routes.draw do
  get 'cart/show'

  devise_for :users
  get 'onboarding/index'

  get 'colors/index'

  get 'colors/new'

  get 'colors/edit'

  root 'tags#index'

  get 'manufacturers/index'
  get 'tags/index'
  get 'tags/excel/import', as: 'new_excel_import', to: 'tags#new_excel_import'
  post 'tags/excel/import', as: 'import_excel', to: 'tags#import_excel'
  post 'tags/excel/submit', as: 'submit_excel', to: 'tags#submit_excel'
  post 'tags/excel/save', as: 'save_excel', to: 'tags#save_excel'
  get 'tags/excel/confirm_colors', as: 'confirm_colors', to: 'tags#confirm_colors'
  get 'onboarding', as: 'onboarding', to: "onboarding#index"

  get 'cart', as: 'cart', to: 'cart#show'
  post 'cart', as: 'add_to_cart', to: 'cart#add_to_cart'
  post 'cart/delete', as: 'delete_from_cart', to: 'cart#delete_from_cart'
  post 'cart/clear', as: 'clear_cart', to: 'cart#clear_cart'
  get 'cart/tags', as: 'cart_tags', to: 'cart#cart_tags'
  get 'cart/download', as: 'download_cart', to: 'cart#download_cart'
  get 'cart/process', as: 'process_cart', to: 'cart#process_cart'

  resources :tags
  resources :colors
  resources :manufacturers


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
