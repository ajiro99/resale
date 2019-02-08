Rails.application.routes.draw do
  root 'sales#index'
  resources :bodies, excpt: %i(show)
  resources :lenses, excpt: %i(show)
  resources :extras, excpt: %i(show)
  resources :stockings, excpt: %i(show)
  resources :sales, excpt: %i(show)
end
