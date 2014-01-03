require_relative '../concerns/paginateable'
module WordifyCms
  module Blog
    module Tags

      # Public: Tag to show a list of posts. The tag includes pagination by
      # default.
      #
      # Usage:
      #
      #  {% blog "pagination": true | "per_page" : 2 %}
      #     {% for post in posts %}
      #       ...
      #     {% endfor %}
      #  {%endblog%}
      #
      class PostsList < Blocks::Base
        include Paginateable

        register_tag  "blog"
        collection   'posts'

        %w{ window_size per_page }.each do |attribute|
          attr_reader attribute
          private     attribute
        end

        def render(context)
          site        = context.registers[:controller].current_site
          posts       = WordifyCms::Blog::Post.desc(:created_at)
          pagination  = build_pagination(posts, context)

          context[collection_context] = pagination.fetch("collection")
          context['collection_name']  = collection_context
          context['pagination']       = pagination

          render_all(@nodelist, context)
        end

      end
    end
  end
end