module WordifyCms
  module Blog
    class DisqusConfigController < BaseController
      self.responder = WordifyCms::DefaultResponder

      respond_to :json
      before_filter :authenticate_wordify_cms_account!
      before_filter :find_config

      def show
        respond_with(@disqus_config)
      end

      def update
        @disqus_config.class.accessible_attributes.each do |attribute|
          #params[:blog_disqus_config].stringify_keys
          if attribute.in?(params[:blog_disqus_config])
            value = params[:blog_disqus_config][attribute]
            @disqus_config.send("#{attribute}=", value)
          end
        end
        updated = @disqus_config.save
        respond_to do |format|
          if updated
            format.json do
              render :json => @disqus_config, :status => :ok
            end
          else
            format.json do
              render  :json => @disqus_config.errors,
                      :status => :unprocessable_entity
            end
          end
        end
      end

      private

      def find_config
        @disqus_config = WordifyCms::Blog::DisqusConfig.last
      end
    end
  end
end