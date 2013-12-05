return unless Wordify?

###
# Public: Category model that will be assigned to a blog post entry.
####
class Wordify.BlogCategory extends Wordify.Model
  @resourceName: 'blog_categories'
  @persist Batman.RailsStorage

  @encode 'name'