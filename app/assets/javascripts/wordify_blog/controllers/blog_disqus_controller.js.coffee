return unless Wordify?
###
  Public: Controller to update Disqus general configurations.
###
class Wordify.BlogDisqusConfigController extends Wordify.Controller

  @beforeFilter only: ['edit'], 'renderToolbar'
  @beforeFilter only: ['edit'], 'renderUserNavigation'

  @mixin Wordify.Controllerable
  @mixin Wordify.BlogNavigationable

  routingKey: 'blog_disqus_config'

  edit:->
    if @disqusConfig?
      @disqusConfig.get('errors')?.clear()
    Wordify.BlogDisqusConfig.url = "/blog_disqus_config"
    Wordify.BlogDisqusConfig.load (err, result)=>
      console.log result
      if err
        @checkBanned
      else
        @set('disqusConfig', result[0])
        @renderView('blog_disqus/edit')
        @renderBlogNavigation(active: '#disqus-tab')

  update: (params)->
    Wordify.BlogDisqusConfig.url = "/blog_disqus_config"
    options =
      errorMsg    : 'wordify_cms.notifications.blog.disqus_config.errors.update'
      redirectMsg : 'notifications.blog.disqus_config.updated'
    @disqusConfig.save @handleSaving(options)
