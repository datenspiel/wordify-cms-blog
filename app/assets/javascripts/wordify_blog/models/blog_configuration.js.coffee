return unless Wordify?

class Wordify.BlogConfiguration extends Wordify.Model
  @resourceName: 'blog_config'
  @persist Batman.RailsStorage

  @encode 'blog_main_page_id', 'blog_prefix_slug',
          'blog_post_detail_page_id'

