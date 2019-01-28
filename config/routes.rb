Rails.application.routes.draw do
  resources :bodies, excpt: %i(show)
  resources :lenses, excpt: %i(show)
  resources :stockings, excpt: %i(show)
  resources :sales, excpt: %i(show)
end
