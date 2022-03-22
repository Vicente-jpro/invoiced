Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do 
    resources :contacts do  
      collection do 
        get "search"
      end
    end
  end
  

end
