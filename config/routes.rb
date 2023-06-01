Rails.application.routes.draw do
  root "pages#home"
  resources :conversations, only: [:create, :show]
  post "question", to: "conversations#ask_question"
end
