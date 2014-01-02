return unless Wordify?

class Wordify.BlogConfigurationController extends Wordify.Controller

  @beforeFilter only: ['edit'], 'renderToolbar'
  @beforeFilter only: ['edit'], 'renderUserNavigation'

  @mixin Wordify.Controllerable
  @mixin Wordify.BlogNavigationable

  routingKey: 'blog_configuration'

  edit: ->
    if @blogConfig?
      @blogConfig.get('errors')?.clear()
    Wordify.BlogConfiguration.url = "/blog_config"
    Wordify.Page.url = "/blog/config/pages/blog"
    Wordify.Page.load (pageLoadErr,results)=>
      if pageLoadErr
        @checkBanned(pageLoadErr)
      else
        Wordify.Page.url = "/blog/config/pages/detailview"
        @set('blogPages', results)
        Wordify.Page.load (detailViewLoadErr, detailViewResults) =>
          if detailViewLoadErr
            @checkBanned(detailViewLoadErr)
          else
            Wordify.Page.url = undefined
            @set('blogPostPages', detailViewResults)
            Wordify.BlogConfiguration.load (err,result)=>
              if err
                @checkBanned(err)
              else
                @set('blogConfig', result[0])
                @renderView('blog_config/edit')
                @renderBlogNavigation(active: '#preferences-tab')

  update: (params)->
    @blogConfig.set('blog_main_page_id', \
                    j("#blog-config-posts-slug-prefix-id").val())
    @blogConfig.set('blog_post_detail_page_id', \
                    j("#blog-config-post-detail-page-id").val())

    Wordify.BlogConfiguration.url = "/blog_config"
    options =
      errorMsg    : 'wordify_cms.notifications.blog.configuration.errors.update'
      redirectMsg : 'notifications.blog.configuration.updated'
    @blogConfig.save @handleSaving(options)