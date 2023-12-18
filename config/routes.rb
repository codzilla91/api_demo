Rails.application.routes.draw do
  get '/convert', to: 'currency_converter#convert'
end
