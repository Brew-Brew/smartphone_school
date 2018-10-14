Rails.application.routes.draw do

  namespace :admin do
    resources :quizzes
    resources :subjects
    resources :users
    resources :comments
    resources :posts
    resources :scores

    root to: "quizzes#index"
  end

  get 'user/test'
  get 'user/rank'
  get 'user/mypage'
  get 'quiz/new' => 'quiz#new', as: 'newnew'
  get 'user/complete', as: 'complete'

  get "quiz/new_release" => 'quiz#new_release', :as => :new_release
  get 'quiz/:id/practice' => 'quiz#practice', as: 'practice'
  get 'quiz/:id/score'=>'quiz#score', as: 'score'

  get 'quiz/:id'=> 'quiz#solve', as: 'solve'

  get 'quiz/:id/text'=>'quiz#text', as: 'text'

  get 'quiz/index'
  
  
  devise_for :users
  get 'new'         => 'post#new'       # 글 작성 페이지
  post 'create'     => 'post#create'    # 글 작성
  get 'destroy/:id' => 'post#destroy'   # 글 삭제
  get 'index'       => 'post#index'     # 모든 글 보기
  get 'show/:id'    => 'post#show'      # 특정 글 보기
  get 'edit/:id'    => 'post#edit'      # 글 편집 페이지
  post 'update'     => 'post#update'    # 글 편집
  
  post  'comment/create'                => 'comment#create'     # 댓글 생성
  delete  'comment/destroy/:comment_id' => 'comment#destroy'    # 댓글 삭제
  post  'comment/update/:comment_id'    => 'comment#update'     # 댓글 수정
   devise_scope :user do
    authenticated :user do
      root 'quiz#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
