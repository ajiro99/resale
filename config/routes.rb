Rails.application.routes.draw do
  root 'dash_board#index'

  resources :bodies, excpt: %i(show)
  resources :lenses, excpt: %i(show)
  resources :extras, excpt: %i(show)
  resources :stockings, excpt: %i(show)
  resources :sales, excpt: %i(show)
  resources :notes, only: %i(index update)
end
