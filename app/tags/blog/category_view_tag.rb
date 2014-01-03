module WordifyCms
  module Blog
    module Tags

      # Public: Tag to show a list of posts of a given category. The tag
      # includes pagination by default.
      #
      # Usage:
      #
      #  {% blog_category "pagination": true | "per_page" : 2 %}
      #     {% for post in posts %}
      #       ...
      #     {% endfor %}
      #  {% endblog_category %}
      #
      class CategoryView < Blocks::Base
        include Paginateable

        register_tag  'blog_category'
        collection    'posts'

        %w{ window_size per_page}.each do |attribute|
          attr_reader attribute
          private     attribute
        end

        def render(context)
          category    = WordifyCms::Blog::Category.
                                          find(context.registers[:model_id])
          pagination  = build_pagination(category.posts, context)

          context[collection_context] = pagination.fetch("collection")
          context["collection_name"]  = collection_context
          context["pagination"]       = pagination

          render_all(@nodelist, context)
        end

      end

    end
  end
end
