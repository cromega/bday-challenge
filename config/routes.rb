Rails.application.routes.draw do
  root to: "home#index"
  get "/play", to: "game#index"
  post "/play", to: "game#play"
end
