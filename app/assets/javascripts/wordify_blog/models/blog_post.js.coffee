return unless Wordify?
###
  Public: Blog post entry model. A blog post belongs to category.
###
class Wordify.BlogPost extends Wordify.Model
  @resourceName: 'blog_posts'
  @persist  Batman.RailsStorage

  @encode 'title', 'text', 'category_id'

  @belongsTo 'category', name: 'BlogCategory'