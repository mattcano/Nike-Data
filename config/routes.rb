Nike::Application.routes.draw do

  root :to => 'nike#index'

  get '/speed', :to => 'nike#speed'
  get '/d3.json', :to => 'nike#d3'
  get '/d3-show', :to => 'nike#d3_show'

end
