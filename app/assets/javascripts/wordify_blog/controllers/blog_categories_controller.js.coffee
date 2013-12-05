return unless Wordify?
###
 Public: CRUD controller to handle creating, updating and deleting of blog
 categories.
###
class Wordify.BlogCategoriesController extends Wordify.Controller

  @beforeFilter only: ['index','edit', 'new'], 'renderToolbar'
  @beforeFilter only: ['index','edit', 'new'], 'renderUserNavigation'
  @beforeFilter only: ['index','edit', 'new'], 'toggleBackendContent'

  @mixin Wordify.Controllerable
  @mixin Wordify.BlogNavigationable

  routingKey: 'blog_categories'

  index: ->
    Wordify.BlogCategory.load (err, results) =>
      if err
        @checkBanned
      else
        @set('categories', results)
        @renderView('blog_categories/index')
        @renderBlogNavigation(active: '#category-tab')

  new:->
    @set('category', new Wordify.BlogCategory())
    @renderView('blog_categories/new')
    @renderBlogNavigation()

  edit:(blog_category)->
    Wordify.BlogCategory.find(blog_category.id, (err,result)=>
      @set('category', result)
      @renderView('blog_categories/edit')
      @renderBlogNavigation()
    )

  create: (params)->
    options =
      errorMsg    : 'wordify_cms.notifications.blog.category.errors.save'
      redirectMsg : 'notifications.blog.category.created'
    @_saveOrUpdate(options)

  destroy: (blog_category)->
    console.log "destory"
    message = I18n.t('wordify_cms.notifications.delete_question', \
                     {name: blog_category.get('name')})
    Cms.WordifyDialog.confirm message,
      ok: =>
        self = @
        blog_category.destroy (err)->
          if err
            if err instanceof Batman.ErrorsSet
              alertify.err(I18n.t('wordify_cms.notifications.blog.category.errors.delete'))
            else
              self.checkBanned(err)
          else
            notifyMessage = I18n.t('wordify_cms.notifications.blog.category.deleted',\
                                  {account: blog_category.get("name")})
            self.redirectTo(location: "/blog/categories", notification: notifyMessage, \
                         alert: false, translate: false)
      title: I18n.t('wordify_cms.blog.category.name')

  update: (params)->
    options =
      errorMsg    : 'wordify_cms.notifications.blog.category.errors.update'
      redirectMsg : 'notifications.blog.category.updated'
    @_saveOrUpdate(options)

  _saveOrUpdate: (options)=>
    options.redirect = "/blog/categories"
    @category.save @handleSaving(options)