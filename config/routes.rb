Rails.application.routes.draw do
  resources :bodies, excpt: %i(show)
  resources :lenses, excpt: %i(show)
end
