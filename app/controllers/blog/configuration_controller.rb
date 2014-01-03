module WordifyCms
  module Blog
    class ConfigurationController < BaseController
      respond_to :json

      before_filter :authenticate_wordify_cms_account!
      before_filter :find_configuration, :only => [:show, :update]

      def show
        respond_to do |format|
          format.json do
            render :json => render_json("show")
          end
        end
      end

      def update
        blog_config_params = params["blog_config"]
        page_id           = blog_config_params.delete("blog_main_page_id")
        detail_page_id    = blog_config_params.delete("blog_post_detail_page_id")
        category_page_id  = blog_config_params.delete("category_page_id")

        blog_main_page    = WordifyCms::Page.find(page_id)
        detail_page       = WordifyCms::Page.find(detail_page_id)
        category_page     = WordifyCms::Page.find(category_page_id)

        @configuration.blog_main_page         = blog_main_page
        @configuration.blog_post_detail_page  = detail_page
        @configuration.category_page          = category_page
        @configuration.class.accessible_attributes.each do |attribute|
          @configuration.send("#{attribute}=",
                              blog_config_params.fetch(attribute))
        end
        @configuration.save

        respond_to do |format|
          format.json do
            render :json => render_json("update")
          end
        end

      end

      def pages
        pages = if params["type"].eql?("detailview")
          post_detail_pages
        else
          blog_pages
        end
        respond_with(pages)
      end

      def categories
        respond_with(category_pages)
      end

      private

      def category_pages
        select_pages("WordifyCms::Blog::Tags::CategoryView")
      end

      def blog_pages
        select_pages("WordifyCms::Blog::Tags::PostsList")
      end

      def post_detail_pages
        select_pages("WordifyCms::Blog::Tags::PostView")
      end

      def select_pages(tag_class_name)
        blog_tag = Liquid::Template.tags.detect do |key,value|
          value.to_s.eql?(tag_class_name)
        end.first
        regexp  = Regexp.new("{%\s{0,}#{blog_tag}\\W{1,}")
        pages   = WordifyCms::Page.all.select do |page|
          page.page_type.template.match(regexp)
        end
        pages
      end

      def find_configuration
        @configuration = WordifyCms::Blog::Configuration.last
      end

      def render_json(action)
        Rabl::Renderer.new("wordify_cms/blog/configuration/#{action}",
                           @configuration,
                           {
                             :view_path => self.view_paths,
                             :format => 'hash'
                           }).render
      end

    end
  end
end