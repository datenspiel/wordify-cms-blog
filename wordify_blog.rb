class WordifyBlog < WordifyCms::Extension

  # You may need some routes for your extension:
  #
  # add_routes do
  #   match '/wordifyblogs/:id' => "wordifyblogs#show" %>
  # end

  add_routes do
    resources :blog_posts,      :controller => "blog/post"
    resources :blog_categories, :controller => "blog/category"
  end

end
