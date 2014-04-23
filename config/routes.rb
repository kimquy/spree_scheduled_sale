Spree::Core::Engine.routes.draw do
  # Add this extension's routes here
  namespace :admin do
    resources :scheduled_sales do

    end
  end
end