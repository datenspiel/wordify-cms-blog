class WordifyBlog < WordifyCms::Extension

  # You may need some routes for your extension:
  #
  # add_routes do
  #   match '/wordifyblogs/:id' => "wordifyblogs#show" %>
  # end

  add_routes do
    resources :blog_posts,          :controller => "blog/post"
    resources :blog_categories,     :controller => "blog/category"

    resource  :blog_disqus_config,  :controller => "blog/disqus_config",
                                    :only => [:show, :update]

    match '/blog_disqus_config/:id' => 'blog/disqus_config#update'
  end

end
