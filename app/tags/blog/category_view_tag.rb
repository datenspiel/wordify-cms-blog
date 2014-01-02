module WordifyCms
  module Blog
    module Tags

      class CategoryView < Blocks::Base

        register_tag  'blog_category'
        collection    'posts'

        def render(context)
          category = WordifyCms::Blog::Category.
                                        find(context.registers[:model_id])
          context[collection_context] = category.posts
          context['collection_name']  = collection_context

          render_all(@nodelist, context)
        end

      end

    end
  end
end
