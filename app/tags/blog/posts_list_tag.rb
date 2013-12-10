module WordifyCms
  module Blog
    module Tags

      class PostsList < Blocks::Base

        register_tag  "blog"
        collection   'posts'

        def render(context)
          site = context.registers[:controller].current_site
          context[collection_context] = WordifyCms::Blog::Post.all
          context['collection_name'] = collection_context
          <<-DOC
            page    = context.registers[:page]
            params  = context.registers[:params]
            page_count = params[:page] ? params[:page] : 1
          DOC
          render_all(@nodelist, context)
        end
      end

    end
  end
end