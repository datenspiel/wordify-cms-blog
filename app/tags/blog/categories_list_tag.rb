module WordifyCms
  module Blog
    module Tags

      class CategoriesList < Blocks::Base

        register_tag  'blog_categories'
        collection    'categories'

        def render(context)
          context[collection_context]  = WordifyCms::Blog::Category.all
          context['collection_name']   = collection_context

          render_all(@nodelist, context)
        end

      end

    end
  end
end