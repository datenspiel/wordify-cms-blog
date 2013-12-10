module WordifyCms
  module Blog
    module Tags

      # Public: Various methods useful for performing mathematical operations.
      # All methods are module methods and should be called on the Math module.
      #
      # Usage:
      #
      # {% blog_post_view %}
      #   <h1>{{ post.title}} </h1>
      # {% endblog_post_view %}
      #
      class PostView < Blocks::Base

        register_tag "blog_post_view"

        def render(context)
          begin
            post = WordifyCms::Blog::Post.find(context.registers[:model_id])
            context["post"] = post

            render_all(@nodelist, context)
          rescue => e
            Rails::logger.info e.message
            return ""
          end
        end
      end

    end
  end
end
