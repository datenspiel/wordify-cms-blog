return unless Wordify?
###
 Public: Renders a view and assigns it to the ivar @view.

 Assigning the ivar is necessary to have Wordify.BlogNavigationable#
 renderBlogNavigation to work correctly.

 viewName - The relative view path.
 dest     - The descriptor of which data-yield element the view should
            rendered in. Defaults to 'main'
###
Wordify.Controller::renderView = (viewName, dest='main') ->
  @view = @render source: viewName, into: dest

###
 Public: Save callback.

 options - A JavaScript object to refine the callback handling:
           :errorMsg    - The error message I18n key
           :redirect    - Route to redirect after success
           :redirectMsg - The message I18n key to show after redirect
###
Wordify.Controller::handleSaving = (options) ->
  self = @
  (err)->
    if err
      if err instanceof Batman.ErrorsSet
        alertify.error(I18n.t(options.errorMsg))
      else
        self.checkBanned(err)
    else
      self.redirectTo(location: options.redirect, notification:options.redirectMsg)