# Require any other files here.
#= require_tree ./lib
#= require_tree ./models
#= require_tree ./components
#= require_tree ./mixins
#= require_tree ./cms_core_ext
#= require_tree ./controllers
return unless Wordify?

class Wordify.WordifyBlog extends Wordify.Extension

  ##############################################################################
  # Blog index pages
  ##############################################################################
  @addRoute '/blog', 'blog#index', as: 'blog.index'
  @addRoute '/blog/categories', 'blogCategories#index', \
            as: 'blog_categories.index'

  ##############################################################################
  # Blog posts
  ##############################################################################
  @addRoute '/blog/posts/new', 'blog#new', as: 'blog_posts.new'
  @addRoute '/blog/posts/:id', 'blog#edit', as: 'blog_posts.edit'

  ##############################################################################
  # Blog categories
  ##############################################################################
  @addRoute '/blog/categories/new', 'blogCategories#new', \
            as: 'blog_categories.new'
  @addRoute '/blog/categories/:id', 'blogCategories#edit', \
            as: 'blog_categories.edit'

  ##############################################################################
  # Blog disqus config
  ##############################################################################
  @addRoute '/blog/disqus/config', 'blogDisqusConfig#edit', \
            as: 'blog_disqus_config.edit'

  ##############################################################################
  # Blog general config
  ##############################################################################
  @addRoute '/blog/configuration', 'blogConfiguration#edit', \
            as: 'blog_configuration.edit'

  # Hook in at the end of the toolbar
  @hookIn {
    at          : 'toolbar',
    icon        : 'icon-white icon-search',
    locales     : 'wordify_cms.blog.navigation',
    identifier  : 'wordify_blog',
    route       : 'blog.index',
    afterHookIn : ()->
      console.log("hi")
  }

Wordify.getView = (viewName)->

Cms.Editor.tinyMceOptions = (selector)->
  options =
      selector: selector
      theme: "modern"
      height: 300
      language : I18n.locale
      plugins: [
         "print preview hr fullscreen insertdatetime nonbreaking paste"
      ]
      menubar: "file edit format view"
      toolbar: "undo redo | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | print preview fullscreen",
  return options