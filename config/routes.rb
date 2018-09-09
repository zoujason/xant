Rails.application.routes.draw do
  namespace :xmt do
    namespace :press do
      resources :kendouis
    end
  end
  resources :kenuis
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # namespace :test do
  #   get 'scores/new'
  # end
  #
  # namespace :test do
  #   get 'scores/show'
  # end
  #
  # namespace :test do
  #   get 'tests/index'
  # end
  #
  # namespace :test do
  #   get 'session/new'
  # end
  #
  # namespace :test do
  #   get 'home/index'
  # end
  #
  # namespace :test do
  #   get 'users/new'
  # end
  #
  # namespace :test do
  #   get 'papers/new'
  # end
  #
  # namespace :test do
  #   get 'exams/new'
  # end

  constraints DomainConstraint.new() do
    root to: 'pages#show'
  end
  resources :pages
  resources :oauthwechats




  #match '/:slug(/:controller(/:action(/:id(.:format))))',:constraints => DomainConstraint.new(), :via => :all
  match '/:slug(/:pages(/:id(.:format)))' => 'pages#show', :constraints => DomainConstraint.new(), via: :all
  resources :topics
  resources :searchs do
    collection do
      get :zwgk
      get :gkml
    end
  end
  resources :sharedocs do
    resources :pages
    collection do
      post :list
      get :check
    end
  end
  resources :sessions do
    collection do
      get :logout
    end
  end
  resources :registrations do
    collection do
      get :rule
      post :verify
    end
  end
  resources :passwords do
    collection do
      post :reset
      get :reply
    end
  end
  resources :articles
  resources :comments do
    collection do
      post :post
      post :reply
      post :destroy
    end
  end

  resources :kplj_wx do
    collection do
      get :geek
      get :science
    end
  end

  resources :kplj_wx_member do
    collection do
      post 'register'
      get 'logout'
      post 'login'
      post 'info_edit'
      post 'forget'
      post 'password'
      post 'ajax_user'
    end
  end
  resources :kplj_wx_article do
    collection do
      post 'edit'
      post 'add'
      post 'destroy'
      get 'search'
    end
  end
  resources :kplj_wx_comment do
    collection do
      post 'post'
      post 'reply'
      post 'destroy'
    end
  end

  resources :consultations do
    collection do
      post :list
      get :check
    end
  end
  resources :polls
  resources :tips do
    collection do
      post :list
      get :check
    end
  end


  namespace :xmt do
    namespace :stat do
      resources :page_views do
        collection do
          get :page_by_year
          get :page_by_month
          get :channel_by_year
          get :channel_by_month
          get :article_by_year
          get :article_by_month
          get :get_child_channel
          get :get_child_article
        end
      end
    end
    namespace :core do
      resources :dicts
    end
    namespace :ad do
      resources :advertisements
    end
    namespace :nav do
      resources :menus
      resources :menu_items
    end
    namespace :faq do
      resources :messages
      resources :polls
      resources :answers
      resources :questions
      resources :consultations
      resources :tips
      resources :sharedocs
    end
    namespace :sms do
      resources :notifications
    end
    namespace :asset do
      resources :images do
        collection do
          get :upload_zip_file
          post :zip_file_handle
        end
      end
      resources :styles
      resources :scripts
    end
    namespace :rbac do
      resources :roles
      resources :groups
      resources :menu_accesses
      resources :site_accesses
      resources :dept_accesses
    end
    namespace :staff do
      resources :members
      resources :managers
      resources :depts
      resources :dept_applications
    end
    namespace :press do
      resources :contents
      resources :profiles
      resources :channels
      resources :sensitives
      resources :single_pages do
        collection do
          get 'rdf_type'
        end
      end
      resources :topics do
        collection do
          get 'upload_assets'
          post 'unzip'
          get 'upload_template'
          post 'wirte_template'
          get 'channel_topics'
        end
      end
      resources :templates
      resources :snippets
      resources :page_types
      resources :sources
      resources :articles do
        member do
          get :to_recycle
          get :recovery
        end
        collection do
          get 'lookup'
          get :recycle
          get :recycle_by_site
          post :destroy_batch
          get :delete_pic
          get :delelte_avatar
          post :add_pic
          get :cust_article
        end
      end
      resources :comments do
        collection do
          get :reply
          post :save_reply
          get :del_reply
        end
      end
      resources :kendouis do
        collection do
          get :index_list
        end
      end
      resources :sites do
        resources :channels
        # resources :channels
        resources :notifications
      end

      resources :services
      resources :governments
    end

    resources :sessions do
      collection do
        get :aclear_dates
      end
    end
    resources :members
    resources :addons

    # namespace :xmt_form do
    #   resources :def_forms do
    #     collection do
    #       get :import
    #       post :import_in
    #     end
    #   end
    #   resources :form_records
    # end
    resources :members

    root to: "admin#index"
    #get ':controller(/:action(/:id))'

    namespace :test do
      resources :categories
      resources :questions
      resources :exams
      resources :rand_exams
      resources :fix_exams
      resources :papers do
        collection do
          post :ajax_next
          get :ajax_validate_question_num
        end
      end
      resources :users
      resources :exam_results


      get '/login', to: 'session#new'
      post '/login', to: 'session#create'
      delete '/logout', to: 'session#destroy'

      root to: "home#index"
    end
  end

  namespace :api do
    namespace :v1 do
      resources :sites, only: [:index, :create, :show, :update, :destroy] do
        resources :channels, only: [:index, :create, :show, :update, :destroy]
      end
      resources :channels, only: [:index, :create, :show, :update, :destroy] do
        resources :channels, only: [:index, :create, :show, :update, :destroy]
        resources :articles, only: [:index, :create, :show, :update, :destroy]
      end
      resources :articles, only: [:index, :create, :show, :update, :destroy] do
        resources :comments, only: [:index, :create, :show, :update, :destroy] do
          collection do
            post :add_reply
            post :del_reply
          end
        end
      end
      resources :members do
        collection do
          post :login
          get :logout
          post :register
        end
      end
    end
  end

  #mount Ckeditor::Engine => '/ckeditor'
  #mount RuCaptcha::Engine => "/rucaptcha", as: :rucaptcha

  # ['poll'].each do |site|
  #   #scope  path: site  do
  #     get "/#{site}", to: "#{site}/quiz#display"
  #   #end
  # end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get "/xmt/poll/quiz/:action", controller: "poll/quiz"

  #get "/xmt", to: "xmt/home#index"
  #root to: "xmt/home#index"
  #get '*path', to:  '#controller#action'

  root to: "pages#show"


end
