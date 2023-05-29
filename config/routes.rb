Rails.application.routes.draw do
  root "pages#chat"
  resources :conversations, only: [:create, :show]
  post "question", to: "conversations#ask_question"
end
