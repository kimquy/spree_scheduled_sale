Spree::Core::Engine.routes.draw do
  # Add this extension's routes here
  namespace :admin do
    resources :scheduled_sales do
      collection do
        get :items_search
      end

      resources :item_scheduled_sales, :controller => 'scheduled_sales/item_scheduled_sales' do

      end
    end
  end
end