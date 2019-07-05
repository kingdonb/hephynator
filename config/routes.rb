Rails.application.routes.draw do

  root to: 'temp_clusters#index'

  resources :temp_clusters do
    get 'kubeconfig'
  end
  get '/healthz', to: proc { [200, {}, ['']] }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
