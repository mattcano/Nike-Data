Nike::Application.routes.draw do

  root :to => 'nike#index'

  get '/matt', :to => 'nike#matt'

end
