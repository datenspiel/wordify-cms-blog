return unless Wordify?
###
  Public: CRUD controller to create, update and destroy blog post entries.
###
class Wordify.BlogController extends Wordify.Controller

  @beforeFilter only: ['index','edit', 'new'], 'renderToolbar'
  @beforeFilter only: ['index','edit', 'new'], 'renderUserNavigation'
  @beforeFilter only: ['index','edit', 'new'], 'toggleBackendContent'

  @mixin Wordify.Controllerable
  @mixin Wordify.BlogNavigationable

  routingKey: 'blog_posts'

  new: ->
    Wordify.BlogCategory.load (err, results) =>
      if err
        @checkBanned
      else
        @set('categories', results)
        @set('post', new Wordify.BlogPost())

        @renderView('blog/new')
        @renderBlogNavigation()

  index:->
    Wordify.BlogPost.load (err, results) =>
      if err
        @checkBanned
      else
        @set('posts', results)
        @renderView('blog/index')
        @renderBlogNavigation(active: '#posts-tab')

  edit: (blog_post)->
    Wordify.BlogCategory.load (err, results) =>
      if err
        @checkBanned
      else
        @set('categories', results)
        Wordify.BlogPost.find(blog_post.id, (err,result)=>
          @set('post', result)
          @renderView('blog/edit')
          @renderBlogNavigation()
        )


  create: (params)->
    @post.set("text", tinymce.get('post_text').getContent())
    options =
      errorMsg    : 'wordify_cms.notifications.blog.post.errors.save'
      redirectMsg : 'notifications.blog.post.created'
    @_saveOrUpdate(options)

  update: (params)->
    textValue = tinymce.get('post_text').getContent()
    @post.set('text', textValue)
    options =
      errorMsg    : 'wordify_cms.notifications.blog.post.errors.update'
      redirectMsg : 'notifications.blog.post.updated'
    @_saveOrUpdate(options)

  destroy: (blog_post)->
    console.log("$destroy")
    message = I18n.t('wordify_cms.notifications.delete_question', \
                     {name: blog_post.get('title')})
    Cms.WordifyDialog.confirm message,
      ok: =>
        self = @
        blog_post.destroy (err)->
          if err
            if err instanceof Batman.ErrorsSet
              alertify.err(I18n.t('wordify_cms.notifications.account.errors.delete'))
            else
              self.checkBanned(err)
          else
            notifyMessage = I18n.t('wordify_cms.notifications.account.deleted',\
                                  {account: blog_post.get("title")})
            self.redirectTo(location: "/blog", notification: notifyMessage, \
                         alert: false, translate: false)
      title: I18n.t('wordify_cms.site.account_management.title')

  _saveOrUpdate: (options)=>
    options.redirect = "/blog"
    @post.save @handleSaving(options)
