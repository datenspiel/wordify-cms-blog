Wordify.BlogNavigationable =
  ###
  Public: Renders the Wordify.Blog navigation.

  options - A javascript object to refine the selection of
            :active - a CSS selector to define which naviagtion item should
                      be marked as active.
  ###
  renderBlogNavigation: (options={})->
    @view.on 'ready', =>
      view = @render source: 'blog/_navigation', into: 'blog_navigation'
      setTimeout =>
        postsIndexRoute     = Wordify.routeFor(routePath: 'blog.index')
        categoryIndexRoute  = Wordify.routeFor(routePath: 'blogCategories.index')

        j('*[data-yield="blog_navigation"]').html(view.get('html'))
        j('#posts-tab a').attr('href', "#!#{postsIndexRoute}")
        j('#category-tab a').attr('href', "#!#{categoryIndexRoute}")

        if options.active
          j(options.active).addClass('active')

      , 200
      return
