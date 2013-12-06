return unless Wordify?
###
# Public: Disqus configuration model.
####
class Wordify.BlogDisqusConfig extends Wordify.Model
  @resourceName: 'blog_disqus_config'
  @persist Batman.RailsStorage

  @encode 'access_token', 'api_key', 'api_secret'

  @validate "access_token", presence: true
  @validate "api_key", presence: true
  @validate "api_secret", presence: true